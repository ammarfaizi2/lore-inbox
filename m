Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267809AbTAMN4f>; Mon, 13 Jan 2003 08:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbTAMN4f>; Mon, 13 Jan 2003 08:56:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7320
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267809AbTAMN4e>; Mon, 13 Jan 2003 08:56:34 -0500
Subject: Re: Nervous with 2.4.21-pre3 and -pre3-ac*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ghugh Song <ghugh@mit.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030113052151.C4594171B7@bellini.mit.edu>
References: <20030113052151.C4594171B7@bellini.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042469573.18624.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 14:52:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 05:21, ghugh Song wrote:
> > Are you using highmem (> 900Mb RAM in the box)
> > 
> > Alan
> 
> Yes, it's got 1 GB of ram in the box of P4 with i845G.
> in an ASUS P4PE motherboard.
> 
> BTW, After several segmentation faults from a few repeated tries 
> of unsuccessful tar command, the machine got frozen.

If you build a kernel with highmem disabled does it become stable ?

