Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVCARqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVCARqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVCARqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:46:52 -0500
Received: from as2.cineca.com ([130.186.84.242]:23439 "EHLO as2.cineca.com")
	by vger.kernel.org with ESMTP id S261999AbVCARqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:46:07 -0500
Message-ID: <1109699163.4224aa5b1e4dc@posta.studio.unibo.it>
Date: Tue,  1 Mar 2005 18:46:03 +0100
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: status of the USB w9968cf.c driver in kernel 2.6?
References: <20050228231430.GW4021@stusta.de>
In-Reply-To: <20050228231430.GW4021@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 151.37.27.128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scrive Adrian Bunk <bunk@stusta.de>: 
 
> I noticed the following regarding the drivers/usb/media/ov511.c driver: 
                                                          ^^^^^^^ 
> - it's not updated compared to upstream: 
 
Could you provide more details? 
 
> - there's no w9968cf-vpp module in the kernel sources 
 
w9968cf-vpp is an optional, gpl'ed module, which can not be included in the 
mainline kernel, as I explained in the documentation of the driver. 
 
Regards, 
      Luca 
 

