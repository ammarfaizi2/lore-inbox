Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUC0Emq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 23:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUC0Eml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 23:42:41 -0500
Received: from 69-150-147-130.ded.swbell.net ([69.150.147.130]:55704 "HELO
	arumekun.no-ip.com") by vger.kernel.org with SMTP id S261677AbUC0Ekz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 23:40:55 -0500
From: Luke-Jr <luke-jr@artcena.com>
To: swsusp-devel@lists.sourceforge.net
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems =?iso-8859-1?q?=5Bwas=09Re=3A_Your_opinion_on_the?= merge?]]
Date: Sat, 27 Mar 2004 04:40:47 +0000
User-Agent: KMail/1.6.1
Cc: Micha Feigin <michf@post.tau.ac.il>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <200403270337.48704.luke-jr@artcena.com> <20040327042849.GB2606@luna.mooo.com>
In-Reply-To: <20040327042849.GB2606@luna.mooo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403270440.47737.luke-jr@artcena.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 March 2004 04:28 am, Micha Feigin wrote:
> Actually it would be very unlikely that grabbing the hard disk would
> enable to boot on another machine since you are restoring all the
> context/modules etc. The grabber would need an identical system, and
> even then I doubt it would work (I don't know how flexible linux and
> the hardware are in this respect.
But a different system *could* be used to analyze the content of the partition 
were it stolen.
>
> Its more a question of grabbing you entire computer and getting access
> to you hard disk, including encrypted partitions. In this case you
> would want to request a key from the user and not use a hardware
> related key.
hardware-related is probably better than an argument, at least.
