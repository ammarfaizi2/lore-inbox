Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270816AbTGPMb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270814AbTGPMb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:31:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16091 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270813AbTGPMbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:31:24 -0400
Date: Wed, 16 Jul 2003 05:36:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: IPv6 warnings
Message-Id: <20030716053635.69b29fa6.davem@redhat.com>
In-Reply-To: <20030716.200728.47761016.yoshfuji@linux-ipv6.org>
References: <20030716113657.A24009@flint.arm.linux.org.uk>
	<20030716.200728.47761016.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 20:07:28 +0900 (JST)
YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:

> > Destroying alive neighbour c18c2a44
> > [<c015bb84>] (dst_destroy+0x0/0x168) from [<bf00d024>] (ndisc_dst_gc+0x74/0xa4 [ipv6])
> 
> Please try this.

Indeed, patch applied, thanks you.

