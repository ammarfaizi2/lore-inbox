Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSLGRc2>; Sat, 7 Dec 2002 12:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSLGRc2>; Sat, 7 Dec 2002 12:32:28 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:20444 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S264617AbSLGRc2> convert rfc822-to-8bit;
	Sat, 7 Dec 2002 12:32:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: error compiling 2.5.50
Date: Sat, 7 Dec 2002 18:39:59 +0100
User-Agent: KMail/1.4.1
References: <200212071817.03142.roy@karlsbakk.net> <200212071826.31636.m.c.p@wolk-project.de>
In-Reply-To: <200212071826.31636.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212071839.59312.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this
> > function)
> > drivers/pci/quirks.c:354: (Each undeclared identifier is reported only
> > once drivers/pci/quirks.c:354: for each function it appears in.)
>
> <movement> RoyK: mail archives are a wonderful thing
> <arashi> patch in bk, insert an 'extern int sis_apic_bug;' as a new line
> before 354

sorry. I sent this email before I asked on #kernelnewbies. Will check more 
before sending next time
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

