Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316375AbSEWKVg>; Thu, 23 May 2002 06:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316431AbSEWKVf>; Thu, 23 May 2002 06:21:35 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:62151 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S316375AbSEWKVf>; Thu, 23 May 2002 06:21:35 -0400
From: <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Halil Demirezen <halild@bilmuh.ege.edu.tr>, <linux-kernel@vger.kernel.org>
Subject: Re: Support for HCF modem.?
Date: Wed, 22 May 2002 22:40:30 +0200
Message-Id: <20020522204030.30304@mailhost.mipsys.com>
In-Reply-To: <20020522201327.GA162@elf.ucw.cz>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Is there any driver for the HCF Conexant PCI modem in the latest kernel?
>> 
>> Conexant have not afaik released source code or documentation, so
don't hold
>> your breath
>
>Actually, both source code and docs is useless for winmodems, at least
>until someone writes v.34 stack :-(.

There is a driver for these. The driver shell is open sourced but links
against
a binary lib containing the soft modem core from conexant.

The driver is maintained by Marc Boucher and available at

<http://www.mbsi.ca/cnxtlindrv/>

Ben.



