Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265010AbTFLVmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265004AbTFLVmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:42:37 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:27402 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S265009AbTFLVmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:42:31 -0400
Date: Thu, 12 Jun 2003 15:56:07 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: rmiller@duskglow.com, linux-kernel@vger.kernel.org
Subject: Re: aic79xx problem
Message-ID: <79280000.1055454967@caspian.scsiguy.com>
In-Reply-To: <200306121639.37085.rmiller@duskglow.com>
References: <200306121639.37085.rmiller@duskglow.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello, I'm hoping that you can help or give me pointers as where to turn.
> 
> We just set up a dual xeon system with an integrated Adaptec Ultra320 
> controller under redhat 8.0.

If you are running the stock driver in 8.0, that could explain things.
More recent drivers can be found here:

http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/
http://people.FreeBSD.org/~gibbs/linux/DUD/aic79xx/
http://people.FreeBSD.org/~gibbs/linux/SRC/

The driver in RH8.0 is probably almost a year out of date.

--
Justin

