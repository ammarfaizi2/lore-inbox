Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283412AbRK2VcF>; Thu, 29 Nov 2001 16:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283409AbRK2Vbz>; Thu, 29 Nov 2001 16:31:55 -0500
Received: from ns.suse.de ([213.95.15.193]:43268 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283408AbRK2Vbh>;
	Thu, 29 Nov 2001 16:31:37 -0500
Date: Thu, 29 Nov 2001 22:31:36 +0100
From: Andi Kleen <ak@suse.de>
To: berthiaume_wayne@emc.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Multicast Broadcast
Message-ID: <20011129223136.B22271@wotan.suse.de>
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB31@corpusmx1.us.dg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB31@corpusmx1.us.dg.com>; from berthiaume_wayne@emc.com on Thu, Nov 29, 2001 at 04:29:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 04:29:22PM -0500, berthiaume_wayne@emc.com wrote:
> 	Andi, forgive my ignorance. I've searched around and can't seem to
> find any references to IP_ADD_MEMBERSHIP and how to use it. I did perform an

man 7 ip

It is a socket option you use in the program that does the multicast
communication.

-Andi
