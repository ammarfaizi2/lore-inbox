Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277252AbRJDWKP>; Thu, 4 Oct 2001 18:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277251AbRJDWKG>; Thu, 4 Oct 2001 18:10:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48912 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277250AbRJDWJv>; Thu, 4 Oct 2001 18:09:51 -0400
Subject: Re: [POT] Which journalised filesystem ?
To: Billy.Harvey@thrillseeker.net (Billy Harvey)
Date: Thu, 4 Oct 2001 23:14:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lk), davej@suse.de (Dave Jones)
In-Reply-To: <1002114032.4911.3.camel@rhino> from "Billy Harvey" at Oct 03, 2001 09:00:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pGle-0004Rv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been using ext3 on my ThinkPad (A20P) for about a month now with
> nary the slightest problem.  I've even smoke tested it by shutting it
> down in the middle of disk writes and it worked fine.

I have no recorded case of an ext3 crash that someone showed was even 
likely to have been disk caching stuff. 
