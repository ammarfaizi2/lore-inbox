Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUD3RoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUD3RoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 13:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUD3RoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 13:44:10 -0400
Received: from sanosuke.troilus.org ([66.92.173.88]:49823 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S263544AbUD3RoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 13:44:06 -0400
To: Marc Boucher <marc@linuxant.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet>
	<40927417.6040100@nortelnetworks.com>
	<DE44B86D-9AC0-11D8-B83D-000A95BCAC26@linuxant.com>
	<40927F6F.9020907@canalmusic.com>
	<765C53A8-9AC6-11D8-B83D-000A95BCAC26@linuxant.com>
From: Michael Poole <mdpoole@troilus.org>
Date: Fri, 30 Apr 2004 13:44:05 -0400
In-Reply-To: <765C53A8-9AC6-11D8-B83D-000A95BCAC26@linuxant.com> (Marc
 Boucher's message of "Fri, 30 Apr 2004 12:50:18 -0400")
Message-ID: <87zn8tmkd6.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher writes:

> I am not threatening anyone, only reminding folks that making
> unsubstantiated public allegations that unfairly damage a person or
> company's reputation is wrong and generally illegal.
>
> Marc

I do not think the allegations are unsubstantiated or unfair; on the
contrary, people have identified with specificity what is offensive
and probably illegal.  Might I remind you of 17 USC 1201(b)(1):

    No person shall manufacture, import, offer to the public, provide,
    or otherwise traffic in any technology, product, service, device,
    component, or part thereof, that -

(A) is primarily designed or produced for the purpose of circumventing
    protection afforded by a technological measure that effectively
    protects a right of a copyright owner under this title in a work
    or a portion thereof;

(B) has only limited commercially significant purpose or use other
    than to circumvent protection afforded by a technological measure
    that effectively protects a right of a copyright owner under this
    title in a work or a portion thereof; or

(C) is marketed by that person or another acting in concert with that
    person with that person's knowledge for use in circumventing
    protection afforded by a technological measure that effectively
    protects a right of a copyright owner under this title in a work
    or a portion thereof.

Issuing the taint warning when a derivative work is created is a right
of the copyright owner(s); you have explained the embedded \0 as a
"mere" technical measure designed to circumvent the taint warning.  In
my reading, that qualifies it as a violation of the paragraph above.

Part or all of 12 USC 1202 may also apply for similar reasons.

The DMCA may be unpopular, but it is still law.

Michael Poole (who is not a lawyer)
