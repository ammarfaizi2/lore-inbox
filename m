Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRKDFTT>; Sun, 4 Nov 2001 00:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278789AbRKDFTJ>; Sun, 4 Nov 2001 00:19:09 -0500
Received: from core.kaist.ac.kr ([143.248.147.118]:55300 "HELO
	core.kaist.ac.kr") by vger.kernel.org with SMTP id <S278795AbRKDFS5> convert rfc822-to-8bit;
	Sun, 4 Nov 2001 00:18:57 -0500
Message-ID: <008f01c164f1$30a06b00$9da5f88f@kaist.ac.kr>
From: "Chul Lee" <chullee@core.kaist.ac.kr>
To: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Cc: "khttpd mailing list" <khttpd-users@zgp.org>
In-Reply-To: <Pine.LNX.4.30.0111031720270.8761-100000@mustard.heime.net>
Subject: Re: [khttpd-users] khttpd vs tux
Date: Sun, 4 Nov 2001 14:26:00 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You had better refer a paper whose tile is High-Performance Memory-Based Web Servers: Kernel and User-Space Performance, by Philippe  at IBM.T.J Watson
They also have experiments on performance between various kernel mode web server and user mode web server.

Chul

----- Original Message ----- 
From: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Cc: "khttpd mailing list" <khttpd-users@zgp.org>
Sent: Sunday, November 04, 2001 1:21 AM
Subject: [khttpd-users] khttpd vs tux


> hi
> 
> can someone tell me what the difference is, in functionality, speed etc.
> between the tux (2.0?) webserver and khttpd? I'm working on a project
> where all I need is raw speed - really raw speed - and I really don't know
> which to choose.
> 
> roy
> 
> ---
> Computers are like air conditioners.
> They stop working when you open Windows.
> 
> _______________________________________________
> khttpd-users maillist  -  khttpd-users@zgp.org
> http://zgp.org/mailman/listinfo/khttpd-users

