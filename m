Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbSJHMAc>; Tue, 8 Oct 2002 08:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbSJHMAc>; Tue, 8 Oct 2002 08:00:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46831 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262205AbSJHMAa>; Tue, 8 Oct 2002 08:00:30 -0400
Date: Tue, 8 Oct 2002 14:06:05 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: William Lee Irwin III <wli@holomorphy.com>
cc: akpm@zip.com.au, <Martin.Bligh@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.41: i386/mm/discontig.c doesn't compile with CONFIG_HIGHMEM
In-Reply-To: <20021008113620.GE12432@holomorphy.com>
Message-ID: <Pine.NEB.4.44.0210081405170.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, William Lee Irwin III wrote:

> On Tue, Oct 08, 2002 at 12:45:05PM +0200, Adrian Bunk wrote:
> > FYI:
> > The compilation of arch/i386/mm/discontig.c fails in both 2.5.41 and
> > 2.5.41-ac1 with the following error when CONFIG_HIGHMEM is enabled:
> > <--  snip  -->
>
> Fix already sent to akpm.
>
> Date:   Sat, 5 Oct 2002 17:05:33 -0700
> From:   William Lee Irwin III <wli@holomorphy.com>
> To:     linux-kernel@vger.kernel.org
> Cc:     linux-mm@kvack.org, akpm@zip.com.au
> Subject: 2.5.40 snapshot ia32 discontig compilefix
> Message-ID: <20021006000533.GE12432@holomorphy.com>


Thanks, I missed this patch.


> Bill

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

