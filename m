Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263050AbTCWNMx>; Sun, 23 Mar 2003 08:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263051AbTCWNMx>; Sun, 23 Mar 2003 08:12:53 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:1218 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263050AbTCWNMw>; Sun, 23 Mar 2003 08:12:52 -0500
Message-ID: <20030323132353.23655.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: gmack@innerfire.net, alan@redhat.com
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Date: Sun, 23 Mar 2003 14:23:52 +0100
Subject: Re: Linux 2.5.65-ac3
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Gerhard Mack <gmack@innerfire.net> 
Date: 	Sat, 22 Mar 2003 22:23:18 -0500 (EST) 
To: Alan Cox <alan@redhat.com> 
Subject: Re: Linux 2.5.65-ac3 
 
> How close are IDE and vt switching to working with preempt ? 
 
Uh? Isn't IDE already working with preempt? At least, 
I'm running 2.5.65-mm4 with IDE + preempt with no 
problems at all (except that when compiling IDE-CDROM 
as a module, it isn't automagically modprobed). 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
