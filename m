Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270913AbTGPPGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270914AbTGPPGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:06:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10954
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270913AbTGPPGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:06:34 -0400
Subject: Re: please help - kernel OOPS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Deon George <kernel@wurley.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716120856.M31641@wurley.net>
References: <20030716120856.M31641@wurley.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058368734.6633.21.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 16:18:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 13:08, Deon George wrote:
> I have been trying some mini-ITX v8000 systems and can get a kernel oops quite 
> easily - most times it is to do with making file systems (reiserfs or ext2/3) or 
> copying via the network (using rsync). Sometimes it happens when the box is 
> booting, and other times it has gone for serveral days before it happened.

I've got a set of EPIA boxes running these kernels - reliably. I would
suggest checking the RAM you used is up to spec first - I had a real
pain of a time with EPIA stuff until I used decent RAM. The stuff that
gave me problems worked fine on some other boards but only at 100Mhz bus
speed on the EPIA.

> I have captured two oops - one when I used mke2fs and one for mkreiserfs (since it 
> oops quite frequently when I make a file system). Does this mean anything to 
> anybody?

Are you within power budget for your system if its a tiny little PSU
brick ?

