Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129461AbRBTMZK>; Tue, 20 Feb 2001 07:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbRBTMZA>; Tue, 20 Feb 2001 07:25:00 -0500
Received: from mail2.aracnet.com ([216.99.193.35]:11781 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S129461AbRBTMYq>; Tue, 20 Feb 2001 07:24:46 -0500
Date: Tue, 20 Feb 2001 04:24:33 -0800
From: Kevin Turner <acapnotic@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.1] system goes glacial, Reiser on /usr doesn't sync
Message-ID: <20010220042433.A11831@troglodyte.menefee>
Reply-To: He-Who-Is-Not-Subscribed-to-LKML 
	  <acapnotic@users.sourceforge.net>
Mail-Followup-To: Kevin Turner <acapnotic@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010220021609.B11523@troglodyte.menefee> <3A92560D.2040304@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3A92560D.2040304@blue-labs.org>; from david@blue-labs.org on Tue, Feb 20, 2001 at 03:33:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 03:33:33AM -0800, David wrote:
> Wild shot in the dark....I'd lay odds that you had about 6-7 Megs free 
> in your buffers/cache line, yes?

David!  You're psychic!


SysRq: Show Memory
Mem-info:
Free pages:         712kB (     0kB HighMem)
( Active: 1779, inactive_dirty: 1507, inactive_clean: 0, free: 178 (192 384 576) )
0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB = 512kB)
0*4kB 1*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB = 200kB)
= 0kB)
Swap cache: add 73994, delete 73947, find 19040/117035
Free swap:       206664kB
12288 pages of RAM
0 pages of HIGHMEM
653 reserved pages
4740 pages shared
47 pages swap cached
0 pages in page table cache
Buffer memory:     6028kB

