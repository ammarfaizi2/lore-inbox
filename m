Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264794AbRFXV5k>; Sun, 24 Jun 2001 17:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbRFXV5a>; Sun, 24 Jun 2001 17:57:30 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:28572 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264791AbRFXV5S>; Sun, 24 Jun 2001 17:57:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Luigi Genoni <kernel@Expansa.sns.it>, <linux-kernel@vger.kernel.org>
Subject: Re: The Joy of Forking
Date: Sun, 24 Jun 2001 10:50:42 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0106241545320.31190-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0106241545320.31190-100000@Expansa.sns.it>
MIME-Version: 1.0
Message-Id: <0106241050420D.01519@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 June 2001 09:46, Luigi Genoni wrote:
> > > 	no SMP
> > > 	x86 only (and similar, e.g. Crusoe)
>
> Is this a joke?
> I hope it is.
>
> Luigi

Nah, I think it's an intentional troll.

Either that or somebody who's So naieve they honestly think that having 
different "text mode" and "binary mode" attributes of files (the cr/lf thing) 
can in some strange way actually improve a system.  (Justifying it with the 
way printers work when sent an ascii text stream, despite the fact that most 
printers these days receive postscript or something equally distant from 
ascii after the printer drivers get done with it.  And that text processing 
itself is, regrettably, moving to Unicode.)

Rob

