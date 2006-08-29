Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWH2Qxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWH2Qxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWH2Qxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:53:45 -0400
Received: from mail.freedom.ind.br ([201.35.65.90]:20458 "EHLO
	mail.freedom.ind.br") by vger.kernel.org with ESMTP id S965156AbWH2Qxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:53:43 -0400
From: Otavio Salvador <otavio@debian.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Failed to setup console
Organization: O.S. Systems Ltda.
References: <873bbfsoqv.fsf@neumann.lab.ossystems.com.br>
	<Pine.LNX.4.61.0608291443540.9815@yvahk01.tjqt.qr>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Tue, 29 Aug 2006 13:53:11 -0300
In-Reply-To: <Pine.LNX.4.61.0608291443540.9815@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Tue, 29 Aug 2006 14:44:26 +0200 (MEST)")
Message-ID: <87r6yzv5zc.fsf@neumann.lab.ossystems.com.br>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>Hello,
>>
>>I'm trying to use 2.6.18-rc5 but it doesn't work to me. I failed to
>>identify what's missing or if it's a bug somewhere.
>>
>>My system, while booting, shows that it fails to setup a console. I'm
>>attaching my .config for reference.
>
> Precise error messages please.
>
> You most likely lack /dev/console.

You gotcha!

Worked fine!

Thanks!

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
