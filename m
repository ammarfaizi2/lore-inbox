Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264168AbRFNXIa>; Thu, 14 Jun 2001 19:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264172AbRFNXIU>; Thu, 14 Jun 2001 19:08:20 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:5560 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S264168AbRFNXII>; Thu, 14 Jun 2001 19:08:08 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Ognen Duzlevski <ognen@gene.pbi.nrc.ca>
Subject: Re: threading question (results after thread pooling)
Date: Fri, 15 Jun 2001 01:20:26 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010614230814Z264168-17720+4087@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
> I have implemented thread pooling (with an environment variable
> where I can give the number of threads to be created). Results:
>
> 1. Linux, no change in the times (not under 2.2.x or 2.4)
[snip]
> I am now pretty much inclined to believe that it is either a) hardware
> issue (someone mentioned that SPARCs and MIPSes handle things differently)
> or b) Linux for some reason just cant give me what IRIX/Solaris can in
> this particular case
[snip]

Hello Ognen,

can you get your hands on an dual AMD Athlon MP 1/1.2 GHz system?
The only mobo currently on the marked is the AMD 760MP based Tyan Thunder K7.
It has (all) the good stuff (Point-to-Point bus, crossbar) which former only 
the (big) Alphas/SUN/SGI etc. had.

http://www.amd.com/products/cpg/server/athlon/index.html
http://www.tyan.com/products/html/thunderk7.html

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
