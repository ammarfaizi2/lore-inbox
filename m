Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSHVVfZ>; Thu, 22 Aug 2002 17:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSHVVfZ>; Thu, 22 Aug 2002 17:35:25 -0400
Received: from flrtn-5-m1-95.vnnyca.adelphia.net ([24.55.70.95]:54997 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S317349AbSHVVfY>;
	Thu, 22 Aug 2002 17:35:24 -0400
Message-ID: <3D655A12.7080706@tmsusa.com>
Date: Thu, 22 Aug 2002 14:39:30 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020818
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: conman@kolivas.net, linux-kernel@vger.kernel.org
Subject: Re: Combined performance patches for 2.4.19
References: <200208221733.29976.conman@kolivas.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a tedious job merging all these patches
and your work is appreciated -  Danke!

Pleasd, send notice when the low latency
patches are merged in too -

Joe



Con Kolivas wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>After the positive feedback from users with my patch for 2.4.18 and requests 
>for the latest kernel I've combined the following patches:
>
>O(1) scheduler
>Preemptible
>
>These are based on the latest patches available for the 2.4.19 kernel. I will 
>be merging the latest low latency patch soon also. It seems to work nicely so 
>far, but would be interested to know how others fare. I've not tried SMP as I 
>dont have an SMP machine.
>
>The combined patch against 2.4.19 (and now a diff patch for preemptible on top 
>of O(1)) can be found here:
>
>http://kernel.kolivas.net
>
>Thanks again to all the real kernel developers for making this possible
>
>Con Kolivas
>
>P.S. Please CC me as not subscribed to LKML.
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.0.6 (GNU/Linux)
>Comment: For info see http://www.gnupg.org
>
>iD8DBQE9ZJO+F6dfvkL3i1gRAsSLAJ0Qg7My/e45ZOdoYoKNcf9OLUgudwCfenhZ
>mjDg76DW3QLXuC4PT4sf8lI=
>=apfI
>-----END PGP SIGNATURE-----
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



