Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUHWOUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUHWOUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUHWOUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:20:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26816 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264500AbUHWOUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:20:00 -0400
Date: Mon, 23 Aug 2004 09:59:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Thomas Richter <thor@math.TU-Berlin.DE>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] NetMOS 9805 ParPort interface
Message-ID: <20040823125935.GF4569@logos.cnet>
References: <200408051143.NAA23740@cleopatra.math.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051143.NAA23740@cleopatra.math.tu-berlin.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 01:43:13PM +0200, Thomas Richter wrote:
> 
> Hi folks,
> 
> here's a tiny patch against parport/parport_pc.c for kernel 2.4.26.
> It adds support for the NetMOS 9805 chip, used in several popular
> parallel port extension cards available here in germany. The patch below
> has been found working in a beige G3 Mac and a Canon BJC just fine.

Thomas,

I just applied this to v2.4 tree.

However your new ID's haven't made their way through v2.6, I can't 
find em in 2.6.8.1-mm4.
