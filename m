Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314238AbSEBCom>; Wed, 1 May 2002 22:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314241AbSEBCol>; Wed, 1 May 2002 22:44:41 -0400
Received: from dsl-213-023-038-139.arcor-ip.net ([213.23.38.139]:52634 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314238AbSEBCok>;
	Wed, 1 May 2002 22:44:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 04:44:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172jRy-0001rq-00@starship> <20020502023350.GE32767@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172k6X-0001sN-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 04:33, William Lee Irwin III wrote:
> Actually, now that I think about it, a contiguously-allocated B-tree of
> extents doesn't sound bad at all, even without additional dressing. Do
> you think it's worth a try?

If it solves a problem on a real machine, certainly.

-- 
Daniel
