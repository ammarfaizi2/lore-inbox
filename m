Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbTCRPaF>; Tue, 18 Mar 2003 10:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbTCRPaE>; Tue, 18 Mar 2003 10:30:04 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:44749 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262442AbTCRPaE>; Tue, 18 Mar 2003 10:30:04 -0500
Message-ID: <20030318154028.32358.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: mersan@ceng.metu.edu.tr, linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2003 16:40:28 +0100
Subject: Re: process resident in memory
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Mehmet Ersan TOPALOGLU <mersan@ceng.metu.edu.tr> 
Date: 	Tue, 18 Mar 2003 16:21:49 +0200 
To: linux-kernel@vger.kernel.org 
Subject: Re: process resident in memory 
 
> first of all i don't have chance to modify the process' code. 
> the thing mlockall does is exactly what i am trying to do 
> (at least a part of it). 
>  
> So your answer is he couldn't know about user-mode so it is not possible. 
> What if kernel forks that process or somehow its process id is informed  
> to kernel? 
 
What about nicing the process to real-time? 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
