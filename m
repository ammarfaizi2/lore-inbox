Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283696AbRK3QXh>; Fri, 30 Nov 2001 11:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283704AbRK3QXY>; Fri, 30 Nov 2001 11:23:24 -0500
Received: from pop.digitalme.com ([193.97.97.75]:43979 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S283706AbRK3QVr>;
	Fri, 30 Nov 2001 11:21:47 -0500
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge the
	problem!
From: "Trever L. Adams" <vichu@digitalme.com>
To: Jessica Blank <jessica@twu.net>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0111301002110.3351-100000@twu.net>
In-Reply-To: <Pine.LNX.4.40.0111301002110.3351-100000@twu.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 11:20:43 -0500
Message-Id: <1007137256.1244.0.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-30 at 11:02, Jessica Blank wrote:
> Sooo... having the Windows-type person remove NetBEUI and Windows
> filesharing (SMB) would fix this if this is indeed the cause of problems?
> 

Partially.  SMB can be an ok netizen given that you disable NetBEUI and
possibly IPX.  It won't be the best netizen, but it won't be so insanely
broken.

Trever

