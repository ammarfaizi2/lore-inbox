Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbUKHNbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUKHNbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 08:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUKHNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 08:31:08 -0500
Received: from smtp.persistent.co.in ([202.54.11.65]:47045 "EHLO
	smtp.pspl.co.in") by vger.kernel.org with ESMTP id S261518AbUKHNbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 08:31:03 -0500
Message-ID: <418F752E.80606@persistent.co.in>
Date: Mon, 08 Nov 2004 19:01:26 +0530
From: Sumesh <sumesh_kumar@persistent.co.in>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Kujau <evil@g-house.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ensoniq ES1371 not working.
References: <418F09F5.10406@persistent.co.in> <418F72F9.5050900@g-house.de>
In-Reply-To: <418F72F9.5050900@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its a standard Linux kernel. Though i will other re-compiled kernels, 
will check on them too. Thanks

Regards,
Sumesh



Christian Kujau wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Sumesh schrieb:
>  
>
>>Hi,
>>
>>    I have a Ensoniq ES1371 sound card on a RH 9 (2.4.20-8). When i try
>>to load my module i get the following errors.
>>
>>shell -  insmod /lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o
>>/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol
>>unregister_sound_mixer_R7afc9d8a
>>    
>>
>
>[...]
>
>this is the standard RH kernel? or did you re-compile their source?
>if yes, did you "make clean" before and "make modules_install" afterwards?
>
>Christian.
>- --
>BOFH excuse #317:
>
>Internet exceeded Luser level, please wait until a luser logs off before
>attempting to log back on.
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.5 (GNU/Linux)
>Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
>iD8DBQFBj3L4+A7rjkF8z0wRAjoYAKC6+7YFi+75ENZTeuSvza2xfn/oIgCgzWOM
>oBfSEyM52hB87WC3aZ1PEz8=
>=qdIs
>-----END PGP SIGNATURE-----
>
>  
>
