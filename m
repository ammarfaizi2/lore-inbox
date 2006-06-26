Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWFZL3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWFZL3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWFZL3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:29:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39557 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750790AbWFZL3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:29:49 -0400
Subject: Re: Expertise required:USB bulk-throughput and memory leak
	detection
From: Arjan van de Ven <arjan@infradead.org>
To: bhuvan.kumarmital@wipro.com
Cc: kernelnewbies@nl.linux.org, kernel-mentors@selenic.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <24ED22E506B5A042BF5B05B6B017D86C0A9016@PNE-HJN-MBX01.wipro.com>
References: <24ED22E506B5A042BF5B05B6B017D86C0A9016@PNE-HJN-MBX01.wipro.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 13:29:37 +0200
Message-Id: <1151321378.3185.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 15:50 +0530, bhuvan.kumarmital@wipro.com wrote:
>  
> 

you made the same mistake here as on kernelnewbies.. you didn't post a
pointer to the source code ;)


> > -----Original Message-----
> > From: Bhuvan Kumarmital (WT01 - Semiconductors & Consumer 
> > Electronics) 
> > To: 'kernelnewbies@nl.linux.org'
> > Subject: Expertise required:USB bulk-throughput and memory 
> > leak detection 
> > 
> >  
> >     My team is developing a device driver for a PCMCIA based 
> > USB device. We're currently trying to test the performance of 
> > our driver. However we're unable to figure out a reliable methods of:
> > 1.) detecting memory leaks caused by our driver code. 
> > 2.) Neither have we been able to find a tool which shows % 
> > utilisation of kernel memory used by our driver.(kernel 
> > memory monitoring)
> > 3.) Throughput calculation of bulk data transfer is also not 
> > precise. We still rely on measuring time on stop watch, while 
> > Transferring data.
> >  
> > About the memory monitoring, there are quite a few tools 
> > available at the application level (like free and top which 
> > are available with the operating system itself). But none for 
> > the kernel level. 
> >  
> > Please suggest other feasible ways of detecting leaks and 
> > monitoring kernel memory utilisation for kernel 2.6.15.4 on 
> > fedora core 4.
> >  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

