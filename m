Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbTDILYd (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 07:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbTDILYc (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 07:24:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20891
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262996AbTDILYc (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 07:24:32 -0400
Subject: Re: help DMA FIFO buffer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dave <davekern@ihug.co.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002e01c2ff18$2f043ca0$0b721cac@stacy>
References: <002e01c2ff18$2f043ca0$0b721cac@stacy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049884662.9901.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 11:37:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-10 at 05:18, dave wrote:
> Hi I am writing a device driver LNVRM is uses DMA for commands and data
> i need a function that will wait until their is enough room in the FIFO for
> the new
> data this function works but their must be a better way I need a formula
> that dose
> not have if's in it

Why ?

