Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSGDL46>; Thu, 4 Jul 2002 07:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSGDL45>; Thu, 4 Jul 2002 07:56:57 -0400
Received: from ds217-115-141-141.dedicated.hosteurope.de ([217.115.141.141]:26628
	"EHLO ds217-115-141-141.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id <S317392AbSGDL45>; Thu, 4 Jul 2002 07:56:57 -0400
Date: Thu, 4 Jul 2002 13:59:30 +0200
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk IO statistics still buggy
Message-ID: <20020704135930.B17481@ds217-115-141-141.dedicated.hosteurope.de>
References: <20020704135231.A17481@ds217-115-141-141.dedicated.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020704135231.A17481@ds217-115-141-141.dedicated.hosteurope.de>; from jo-lkml@suckfuell.net on Thu, Jul 04, 2002 at 01:52:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The IO statistics displayed in /proc/partitions are still buggy, because
> after some time, the value for the currently running requests gets too
> high or too low (see the archives, look for "/proc/partitions").
I forgot: This is on all recent 2.4 kernels; I can't tell for 2.5.

Bye
Jochen

