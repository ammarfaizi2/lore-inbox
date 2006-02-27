Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWB0NPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWB0NPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 08:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWB0NPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 08:15:39 -0500
Received: from mail.freedom.ind.br ([201.35.65.90]:9660 "EHLO
	mail.freedom.ind.br") by vger.kernel.org with ESMTP id S932308AbWB0NPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 08:15:38 -0500
From: Otavio Salvador <otavio@debian.org>
To: linux-kernel@vger.kernel.org
Subject: ALSA HDA Intel stoped to work in 2.6.16-*
Organization: O.S. Systems Ltda.
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Mon, 27 Feb 2006 10:15:25 -0300
Message-ID: <87wtfhx7rm.fsf@nurf.casa>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was using 2.6.15 without trouble but wanna try the new 2.6.16
version so I compiled it by myself without much hassle. All worked
fine but ALSA.

My sound device is the following:

0000:00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)

and it stoped to work. Would someone know anything about it? it's a
regressions if compared to 2.6.15.

If you wish something more, please let me know.

Thanks in advance,

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
