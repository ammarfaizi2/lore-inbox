Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268263AbTBMTHy>; Thu, 13 Feb 2003 14:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268264AbTBMTHx>; Thu, 13 Feb 2003 14:07:53 -0500
Received: from rth.ninka.net ([216.101.162.244]:388 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S268263AbTBMTHv>;
	Thu, 13 Feb 2003 14:07:51 -0500
Subject: Re: IPv6 in the vanilla tree?
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: YOSHIFUJI Hideaki "/ ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
       Robert.L.Harris@rdlg.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030213161100.A3399@infradead.org>
References: <20030213135702.GE4377@rdlg.net>
	<20030213.230441.54189804.yoshfuji@linux-ipv6.org> 
	<20030213161100.A3399@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Feb 2003 12:00:09 -0800
Message-Id: <1045166409.7435.6.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 08:11, Christoph Hellwig wrote:
> Btw, is there any chance you could make snapshot patches for 2.5 available
> as you do for 2.4?  Given the number of change in the 2.4 tree it might be
> interesting what's still missing for 2.5.

ipv6 should be basically identical between 2.4.x and 2.5.x

The only difference is IPSEC, and even for that the ipv6
portions are still only in their most basic stages.

I bet that all their 2.4.x patches apply pretty cleanly to 2.5.x

