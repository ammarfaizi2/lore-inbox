Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290833AbSARV1l>; Fri, 18 Jan 2002 16:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290830AbSARV1c>; Fri, 18 Jan 2002 16:27:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42762 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290833AbSARV1U>; Fri, 18 Jan 2002 16:27:20 -0500
Subject: Re: vm philosophising
To: davids@webmaster.com (David Schwartz)
Date: Fri, 18 Jan 2002 21:39:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020118201715.AAA18233@shell.webmaster.com@whenever> from "David Schwartz" at Jan 18, 2002 12:17:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RgjR-0007xw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 18 Jan 2002 19:23:47 +0000 (GMT), Alan Cox wrote:
> 
> >Overcommit control is just a book keeping
> >exercise on address space commits.
> 
> 	A bookkeeping technique developed by Arthur Anderson.

Hardly, and for many workloads its actually a very good thing to do. Of
course there is always a small mostly theoretical risk of doing an Enron
