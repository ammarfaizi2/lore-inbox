Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292657AbSCMHoO>; Wed, 13 Mar 2002 02:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292648AbSCMHoE>; Wed, 13 Mar 2002 02:44:04 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:20875 "EHLO
	starship") by vger.kernel.org with ESMTP id <S292639AbSCMHnv>;
	Wed, 13 Mar 2002 02:43:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, wli@holomorphy.com
Subject: Re: 2.4.19pre2aa1
Date: Wed, 13 Mar 2002 08:37:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020313010652.F14628@holomorphy.com> <3C8EAA6A.9E040BC3@zip.com.au>
In-Reply-To: <3C8EAA6A.9E040BC3@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16l3K9-0000Cf-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 13, 2002 02:24 am, Andrew Morton wrote:
> wli@holomorphy.com wrote:
> > This looks like a change of invariants that could generate a fair
> > amount of audit work. Ugh...
> 
> In a better world, the VM wouldn't know anything at all about
> these "buffer" thingies.

;-)

-- 
Daniel
