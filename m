Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWBBRlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWBBRlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWBBRlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:41:37 -0500
Received: from goofy.fi.upm.es ([138.100.8.23]:21515 "EHLO goofy.fi.upm.es")
	by vger.kernel.org with ESMTP id S1750751AbWBBRlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:41:36 -0500
Date: Thu, 02 Feb 2006 18:40:27 +0100
From: egallego@babel.ls.fi.upm.es (Emilio =?utf-8?Q?Jes=C3=BAs?= Gallego
	Arias)
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-reply-to: <Pine.LNX.4.64.0602020757480.21884@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Karim Yaghmour <karim@opersys.com>,
       Filip Brcic <brcha@users.sourceforge.net>,
       Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <87zml97j78.fsf@babel.ls.fi.upm.es>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk>
 <43DE57C4.5010707@opersys.com>
 <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com>
 <200601302301.04582.brcha@users.sourceforge.net>
 <43E0E282.1000908@opersys.com> <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org>
 <43E1C55A.7090801@drzeus.cx> <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org>
 <87mzha85sc.fsf@babel.ls.fi.upm.es>
 <Pine.LNX.4.64.0602020757480.21884@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Besides, the people who inserted the DRM code explicitly gave you 
> permission to modify it, so the whole point is moot. There's no 
> "circumvention".

Yes, it is mostly clear, and indeed GPL3 seems a little bit over
engineered, but that doesn't mean that GPL2 could not have any
loopholes:

1. Release a kernel with builtin DRM for video. (For example HDCP [1])
   Such DRM implementation is released under the GPL2 by copyright
   holder A.

2. Distribute a modified kernel without DRM. Copyright holder A gave
   you permission to do so, by the GPL2, everything is OK.

3. People can backup videos from copyright holder B using the modified
   kernel.

4. Copyright holder B can sue you under the DMCA, for circumventing an
   effective technological measure. It doesn't matter whatever license 
   copyright holder A gave you.

Regards,

Emilio

Footnotes: 
[1]  High-Bandwidth Digital Content Protection. Currently you would
never get a license for a GPL implementation, but it's used as an
hypothetical example.

