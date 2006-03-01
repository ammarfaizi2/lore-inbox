Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWCAN7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWCAN7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCAN7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:59:22 -0500
Received: from gate.in-addr.de ([212.8.193.158]:21731 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751030AbWCAN7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:59:22 -0500
Date: Wed, 1 Mar 2006 14:59:16 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] LiSt - Linux Statistics - www.linux-stats.org
Message-ID: <20060301135916.GD23159@marowsky-bree.de>
References: <200602281812.42318.dma147@linux-stats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602281812.42318.dma147@linux-stats.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-02-28T18:12:37, Alexander Mieland <dma147@linux-stats.org> wrote:

>  - The installation date of your distribution
>  - The hostname (no fqdn or ips)
>  - The architecture (x86/i586/i686, ppc, and so on)
>  - CPU information: vendor, model, number of cpus, frequencies
>  - RAM
>  - Swap
>  - Timezone
>  - user defined locales
>  - Windowmanager
>  - Kernel version
>  - Uptime information
>  - The size of mounted partitions (no shares)
>  - the used filesystems
>  - The hardware-IDs of used ISA/PCI/AGP and USB hardware

This is very useful to focus development, eventually. It would be nice
if you could also come up with a way to provide feedback on the kernel
modules used (loaded will do, but used would be cuter ;-).


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

