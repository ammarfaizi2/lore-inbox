Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSGYObH>; Thu, 25 Jul 2002 10:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSGYObH>; Thu, 25 Jul 2002 10:31:07 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:35337 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314680AbSGYObH>; Thu, 25 Jul 2002 10:31:07 -0400
Date: Thu, 25 Jul 2002 15:34:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
Cc: linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0.5 patch for Linux 2.4.19-rc3
Message-ID: <20020725153419.A12435@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
	linux-kernel@vger.kernel.org, mge@sistina.com
References: <20020725153944.A8060@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725153944.A8060@sistina.com>; from mauelshagen@sistina.com on Thu, Jul 25, 2002 at 03:39:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 03:39:44PM +0200, Heinz J . Mauelshagen wrote:
> 
> All,
> have send an LVM 1.0.5 patch to Marcelo directly which addresses:
> 
> - an OBO error accessing the vg array
> - SMP lock fixes
> - using blk_ioctl()
> - indenting

Any estimate when Stephen's non-broken pvmove implementaion will be merged?

