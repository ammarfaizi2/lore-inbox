Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317982AbSGPVNy>; Tue, 16 Jul 2002 17:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSGPVNx>; Tue, 16 Jul 2002 17:13:53 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16626 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317982AbSGPVNw>; Tue, 16 Jul 2002 17:13:52 -0400
Subject: Re: PROBLEM: Kernel panics on bootup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Snyder <csnyder@mvpsoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D345AD7.1010509@mvpsoft.com>
References: <3D345AD7.1010509@mvpsoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Jul 2002 23:27:12 +0100
Message-Id: <1026858432.1687.85.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 18:41, Chris Snyder wrote:
> SMP motherboard not detected.

Whatever it is it is apparently not Intel MP1.x compliant. Boxes
predating mass use of MP1.x basically dont work SMP in Linux.


