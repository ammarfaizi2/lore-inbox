Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbTCLTIv>; Wed, 12 Mar 2003 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261920AbTCLTIv>; Wed, 12 Mar 2003 14:08:51 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:52904 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S261916AbTCLTIt>; Wed, 12 Mar 2003 14:08:49 -0500
Message-ID: <20030312191916.20499.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: jjs@tmsusa.com, linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2003 20:19:16 +0100
Subject: Re: named vs 2.5.64-mm5
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: jjs <jjs@tmsusa.com> 
Date: 	Wed, 12 Mar 2003 10:29:12 -0800 
To: linux kernel <linux-kernel@vger.kernel.org> 
Subject: named vs 2.5.64-mm5 
 
> Greetings - 
>  
> 2.5.64-mm4 and -mm5 seem more rugged than previous 
> kernels, but there are a couple of minor nits - one of them 
> is the tendency of named (which appears to work reliably 
> under 2.4) to go catatonic under recent 2.5.6x kernels - 
>  
> More verbose kernel logging may shed some light - or is 
> this just a red herring? I get a tons of these in 2.5.64-mm5: 
>  
> <...> 
> process `named' is using obsolete setsockopt SO_BSDCOMPAT 
> process `named' is using obsolete setsockopt SO_BSDCOMPAT 
> process `named' is using obsolete setsockopt SO_BSDCOMPAT 
> <...> 
>  
> Anybody here running a compliant version of named? 
>  
> (This is the bind 9.2.1 which ships with Red Hat 8.0) 
 
I would recommend you downloading BIND 9.2.2. It fixes many 
bugs. Else, try the latest BIND from RedHat's RawHide repository. 
HTH 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
