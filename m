Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbUCCOFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 09:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbUCCOFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 09:05:24 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:51596 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262346AbUCCOFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 09:05:20 -0500
Date: Wed, 3 Mar 2004 15:05:13 +0100
From: David Weinehall <david@southpole.se>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-bk7 i8042 does not work on a genuine i386 ibm ps/2 model 70.
Message-ID: <20040303140513.GX19111@khan.acc.umu.se>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
References: <m1znb29css.fsf@ebiederm.dsl.xmission.com> <20040303101347.GB310@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303101347.GB310@ucw.cz>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 11:13:47AM +0100, Vojtech Pavlik wrote:
> On Sun, Feb 29, 2004 at 07:32:19AM -0700, Eric W. Biederman wrote:
[snip]

> Does the machine by any chance have a PS/2 mouse port? If not, it may be
> the reason - it would have an AT-style i8042, and those might not be
> implementing that bit.

ALL PS/2's have PS/2 mouse ports.  Guess where the name comes from...

[snip]


Regards: David weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
