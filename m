Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268074AbTBMQB1>; Thu, 13 Feb 2003 11:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268075AbTBMQB0>; Thu, 13 Feb 2003 11:01:26 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:26122 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268074AbTBMQBY>; Thu, 13 Feb 2003 11:01:24 -0500
Date: Thu, 13 Feb 2003 16:11:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: Robert.L.Harris@rdlg.net, linux-kernel@vger.kernel.org
Subject: Re: IPv6 in the vanilla tree?
Message-ID: <20030213161100.A3399@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	Robert.L.Harris@rdlg.net, linux-kernel@vger.kernel.org
References: <20030213135702.GE4377@rdlg.net> <20030213.230441.54189804.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030213.230441.54189804.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Thu, Feb 13, 2003 at 11:04:41PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 11:04:41PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> In article <20030213135702.GE4377@rdlg.net> (at Thu, 13 Feb 2003 08:57:02 -0500), "Robert L. Harris" <Robert.L.Harris@rdlg.net> says:
> 
> > alot of web pages out etc.  From the horses mouth though, what's the
> > state of IPv6 in the 2.4.X (20?) kernel trees?  Will it be stable enough
> > in 2.4.21/22 that it won't require usagi patches or will that be in 2.6,
> > etc?
> 
> 2.4.21 will come with (most of) our changes which are already in 2.5.xx 
> series.  Please not that we'll continue making patches for 2.5.xx and 
> 2.4.xx.

Btw, is there any chance you could make snapshot patches for 2.5 available
as you do for 2.4?  Given the number of change in the 2.4 tree it might be
interesting what's still missing for 2.5.

