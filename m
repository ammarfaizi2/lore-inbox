Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSHVUMs>; Thu, 22 Aug 2002 16:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHVUMs>; Thu, 22 Aug 2002 16:12:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:29940 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316673AbSHVUMs>; Thu, 22 Aug 2002 16:12:48 -0400
Subject: Re: Patch for PC keyboard driver's autorepeat-rate handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dave Jones <davej@suse.de>,
       James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020822193743.GA5448@win.tue.nl>
References: <Pine.LNX.4.33L2.0208221153210.672-100000@ida.rowland.org>
	<1030037462.3090.1.camel@irongate.swansea.linux.org.uk> 
	<20020822193743.GA5448@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 22 Aug 2002 21:16:14 +0100
Message-Id: <1030047374.3161.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 20:37, Andries Brouwer wrote:
> What it does for KDKBDREP is conform the text of kd.h, and I think
> conform what m68k has done for years (but I've never seen the m68k patch).
> Alan Stern is entirely right that the current 2.4 kernels and the
> current kbdrate program have different ideas about what KDKBDREP does.

XFree86 assumes the existing m68k behaviour from the base m68k tree

