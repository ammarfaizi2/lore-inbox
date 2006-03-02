Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWCBH2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWCBH2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 02:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWCBH2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 02:28:15 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:56583 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751419AbWCBH2O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 02:28:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XIVx3WwVlg/yWBazJ9ZmJJROqsJ/uFyTdE+HBZfbJTtY5ET74+oFqJW7Wr5ncCOanRZgKMHxjZ6XNox9HsG4WbnEQQQCeB3qa+0wKwXAybSSyh4hELwG+kU6eWp6ZLo1KPC4DQfhuMEVnv4MI9L71rk3uWbDJci9lZEED5I4bLA=
Message-ID: <6bffcb0e0603012328kc3e63bfn@mail.gmail.com>
Date: Thu, 2 Mar 2006 08:28:13 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Lars Marowsky-Bree" <lmb@suse.de>
Subject: Re: [ANNOUNCE] LiSt - Linux Statistics - www.linux-stats.org
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060301135916.GD23159@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200602281812.42318.dma147@linux-stats.org>
	 <20060301135916.GD23159@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/06, Lars Marowsky-Bree <lmb@suse.de> wrote:
> On 2006-02-28T18:12:37, Alexander Mieland <dma147@linux-stats.org> wrote:
>
> >  - The installation date of your distribution
> >  - The hostname (no fqdn or ips)
> >  - The architecture (x86/i586/i686, ppc, and so on)
> >  - CPU information: vendor, model, number of cpus, frequencies
> >  - RAM
> >  - Swap
> >  - Timezone
> >  - user defined locales
> >  - Windowmanager
> >  - Kernel version
> >  - Uptime information
> >  - The size of mounted partitions (no shares)
> >  - the used filesystems
> >  - The hardware-IDs of used ISA/PCI/AGP and USB hardware
>
> This is very useful to focus development, eventually. It would be nice
> if you could also come up with a way to provide feedback on the kernel
> modules used (loaded will do, but used would be cuter ;-).
>
>
> Sincerely,
>     Lars Marowsky-Brée

Something like http://klive.cpushare.com/ ?

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
