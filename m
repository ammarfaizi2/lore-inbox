Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311148AbSCTBmO>; Tue, 19 Mar 2002 20:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311180AbSCTBmG>; Tue, 19 Mar 2002 20:42:06 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:5318 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S311148AbSCTBmA>; Tue, 19 Mar 2002 20:42:00 -0500
Date: Tue, 19 Mar 2002 19:41:38 -0600
From: Ken Brownfield <ken@irridia.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP (RH7.2)
Message-ID: <20020319194138.D15811@asooo.flowerfire.com>
In-Reply-To: <E16nUx8-0000w4-00@the-village.bc.nu> <Pine.LNX.4.10.10203191726290.525-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 05:29:39PM -0800, Andre Hedrick wrote:
[...]
| Next, that config option is a distro addition not mine, but it has creeped
| in so it is here.

Ya, Martin has cleaned this up for 2.4 I believe, and I'll do the grunt
work on patches for you and/or Martin to clean up 2.5.  The option is
fine, just that the specific IDE drivers aren't handling the logic
properly and ide-pci does it already.

Thanks!
-- 
Ken.
ken@irridia.com

| Regards,
| 
| Andre Hedrick
| LAD Storage Consulting Group
