Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTB0XN6>; Thu, 27 Feb 2003 18:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTB0XN6>; Thu, 27 Feb 2003 18:13:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58255
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267267AbTB0XN5>; Thu, 27 Feb 2003 18:13:57 -0500
Subject: Re: Problem with compact flash as slave device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Popoff <lkml@tre.bloodletting.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <118.42.1046387492508@tre.bloodletting.com>
References: <118.42.1046387492508@tre.bloodletting.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046392002.14939.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 00:26:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-27 at 23:11, Nick Popoff wrote:
> I'm unable to boot Linux if a compact flash disk is present as a slave
> device on the same IDE chain as the Linux hard disk.  The kernel boots

Fixed in 2.4.21pre6

