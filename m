Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287475AbRLaKEt>; Mon, 31 Dec 2001 05:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287477AbRLaKEk>; Mon, 31 Dec 2001 05:04:40 -0500
Received: from web1.oops-gmbh.de ([212.36.232.3]:45324 "EHLO
	sabine.freising-pop.de") by vger.kernel.org with ESMTP
	id <S287475AbRLaKEY>; Mon, 31 Dec 2001 05:04:24 -0500
Message-ID: <3C30366F.1C76877F@sirius-cafe.de>
Date: Mon, 31 Dec 2001 10:57:03 +0100
From: Martin Knoblauch <knobi@sirius-cafe.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-), Freising
X-Mailer: Mozilla 4.6 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "M. Edward Borasky" <znmeb@aracnet.com>, knobi@knobisoft.de,
        linux-kernel@vger.kernel.org, andihartmann@freenet.de
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0112301910480.24031-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sun, 30 Dec 2001, M. Edward Borasky wrote:
> 
> > Yes!! I second that motion!! On top of that, we need buffer/page cache
> > hit rate statistics!!
>

 Yes, I forgot to mention them. And we need them not only to do the
production planning, but also for developing the VM[-strategies]. Most
time these days we just say things like "it sucks", or "no, it does not"
:-) Even worse if it comes to interactive "feeling".
 
> > If Linux is to succeed in enterprise-level usage, we *must* have tools
> > to measure, manage and tune performance -- in short, to do capacity
> > planning like we do on any other system.
> 
> Indeed, VM statistics added back to the TODO list for
> my VM ;)
>

 Very good to hear.
 
Happy new year
Martin
-- 
+-----------------------------------------------------+
|Martin Knoblauch                                     |
|-----------------------------------------------------|
|http://www.knobisoft.de/cats                         |
|-----------------------------------------------------|
|e-mail: knobi@knobisoft.de                           |
+-----------------------------------------------------+
