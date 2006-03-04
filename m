Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWCDF3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWCDF3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 00:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWCDF3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 00:29:12 -0500
Received: from mail.freedom.ind.br ([201.35.65.90]:49116 "EHLO
	mail.freedom.ind.br") by vger.kernel.org with ESMTP
	id S1751082AbWCDF3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 00:29:12 -0500
From: Otavio Salvador <otavio@debian.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Organization: O.S. Systems Ltda.
References: <87wtfhx7rm.fsf@nurf.casa> <s5hzmkcsv38.wl%tiwai@suse.de>
	<87slq3x3w1.fsf@nurf.casa> <s5hu0ajrbxv.wl%tiwai@suse.de>
	<87fym3w7m3.fsf@nurf.casa> <s5h3bi2a26o.wl%tiwai@suse.de>
	<8764mxiny5.fsf@nurf.casa> <s5h4q2fo0t4.wl%tiwai@suse.de>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Sat, 04 Mar 2006 02:29:02 -0300
In-Reply-To: <s5h4q2fo0t4.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
	03 Mar 2006 19:11:51 +0100")
Message-ID: <87zmk6eq1t.fsf@nurf.casa>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> Are you sure that your device has PCI SUB-system id 8086:2668 ?

oh no! Sorry!

0000:00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: 152d:0729
                   ^^^^^^^^^


-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
