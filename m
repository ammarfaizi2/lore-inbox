Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278373AbRJMT2J>; Sat, 13 Oct 2001 15:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278374AbRJMT17>; Sat, 13 Oct 2001 15:27:59 -0400
Received: from cc1095243-a.thrp1.fl.home.com ([24.37.231.148]:11 "EHLO
	Artifact") by vger.kernel.org with ESMTP id <S278373AbRJMT1q>;
	Sat, 13 Oct 2001 15:27:46 -0400
Message-ID: <02ca01c1541d$391c5f30$c800000a@Artifact>
From: "Wilson" <defiler@null.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011013141709.L249@localhost> <Pine.LNX.4.33L.0110131526500.2847-100000@imladris.rielhome.conectiva> <20011013144220.P249@localhost> <20011013145341.R249@localhost>
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
Date: Sat, 13 Oct 2001 15:28:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Patrick McFarland" <unknown@panax.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, October 13, 2001 2:53 PM
Subject: Re: Which is better at vm, and why? 2.2 or 2.4

>Also, I'd like to say about the documentation...
>
><quote>
>Currently, these files are in /proc/sys/vm:
>- bdflush
>- buffermem
>- freepages
>- kswapd
>- overcommit_memory
>- page-cluster
>- pagecache
>- pagetable_cache
></quote>
>
>but a simple ls of /proc/sys/vm reports:
>bdflush  kswapd  overcommit_memory  page-cluster  pagetable_cache
>
>Shouldnt the documentation be updated, seeing for the fact it was written
in the 2.2.10 days?

I must be confused.. What kernel are you running?
This is on 2.4.8-ac9:
[root@aeon /root]# ls /proc/sys/vm
bdflush    freepages  max_map_count  min-readahead      pagecache
pagetable_cache
buffermem  kswapd     max-readahead  overcommit_memory  page-cluster



