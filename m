Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278395AbRJMUWC>; Sat, 13 Oct 2001 16:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278398AbRJMUVm>; Sat, 13 Oct 2001 16:21:42 -0400
Received: from grip.panax.com ([63.163.40.2]:10251 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S278395AbRJMUVh>;
	Sat, 13 Oct 2001 16:21:37 -0400
Date: Sat, 13 Oct 2001 16:21:55 -0400
From: Patrick McFarland <unknown@panax.com>
To: Wilson <defiler@null.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
Message-ID: <20011013162155.A1665@localhost>
Mail-Followup-To: Wilson <defiler@null.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011013141709.L249@localhost> <Pine.LNX.4.33L.0110131526500.2847-100000@imladris.rielhome.conectiva> <20011013144220.P249@localhost> <20011013145341.R249@localhost> <02ca01c1541d$391c5f30$c800000a@Artifact>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ca01c1541d$391c5f30$c800000a@Artifact>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.12 i586
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im using 2.4.12-linus

On 13-Oct-2001, Wilson wrote:
> ----- Original Message -----
> From: "Patrick McFarland" <unknown@panax.com>
> To: "Rik van Riel" <riel@conectiva.com.br>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Saturday, October 13, 2001 2:53 PM
> Subject: Re: Which is better at vm, and why? 2.2 or 2.4
> 
> >Also, I'd like to say about the documentation...
> >
> ><quote>
> >Currently, these files are in /proc/sys/vm:
> >- bdflush
> >- buffermem
> >- freepages
> >- kswapd
> >- overcommit_memory
> >- page-cluster
> >- pagecache
> >- pagetable_cache
> ></quote>
> >
> >but a simple ls of /proc/sys/vm reports:
> >bdflush  kswapd  overcommit_memory  page-cluster  pagetable_cache
> >
> >Shouldnt the documentation be updated, seeing for the fact it was written
> in the 2.2.10 days?
> 
> I must be confused.. What kernel are you running?
> This is on 2.4.8-ac9:
> [root@aeon /root]# ls /proc/sys/vm
> bdflush    freepages  max_map_count  min-readahead      pagecache
> pagetable_cache
> buffermem  kswapd     max-readahead  overcommit_memory  page-cluster
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Patrick "Diablo-D3" McFarland || unknown@panax.com
