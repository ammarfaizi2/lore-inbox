Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTDXUvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTDXUvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:51:08 -0400
Received: from ant.hiwaay.net ([216.180.54.10]:53256 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id S263458AbTDXUvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:51:07 -0400
Date: Thu, 24 Apr 2003 16:03:16 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424210316.GE735921@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424205035.GE30082@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Jamie Lokier  <jamie@shareable.org> said:
>I wonder whether the FSF shouldn't fork the GPLv3 into two versions,
>according to what philosophy GPLv2 users would like to adopt for their
>own projects :)  (In principle, only the FSF is able to alter the
>license of a many-authored GPL'd project like Linux.  It would be
>unfortunate if they used that special status to promote an agenda
>which a large number existing GPL users disliked).

They can't affect the license of Linux because COPYING included with the
kernel says:

 Also note that the only valid version of the GPL as far as the kernel
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

Now, IIRC, that paragraph was added after the fact, so someone could go
back to a version before that paragraph and fork under a new version of
the GPL, however they could not take any code from the current versions
of the kernel.

About 20% of the files in the kernel include the "at your option" clause
(this is from looking at the source to RH's 2.4.20-8).

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
