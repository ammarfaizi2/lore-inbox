Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280538AbRKBDgJ>; Thu, 1 Nov 2001 22:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280539AbRKBDf7>; Thu, 1 Nov 2001 22:35:59 -0500
Received: from quechua.inka.de ([212.227.14.2]:30810 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S280538AbRKBDfp>;
	Thu, 1 Nov 2001 22:35:45 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: unnumbered interfaces?
In-Reply-To: <200111011522.QAA22531@zhadum.sara.nl>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E15zV7P-0003pM-00@calista.inka.de>
Date: Fri, 02 Nov 2001 04:35:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200111011522.QAA22531@zhadum.sara.nl> you wrote:
>> I'm trying to understand unnumbered interfaces.  From 
>> searching the web, they seem to be point-to-point links 
>> that do not have IP numbers (hence the name). 

It is Cisco Speak. In Linux you simply give the Interface an IP Address of
an exisiting Interface, and then you have an "unnumbered" interface. It
simply means it does not add an additional address.

Routing in modern operating systems is so easy and natural with interface
and host routes, dont worry about cisco legacy.

Greetings
Bernd
