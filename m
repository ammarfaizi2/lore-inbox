Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270821AbTGNVhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270875AbTGNVeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:34:20 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:56814 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S270822AbTGNVdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:33:08 -0400
Date: Mon, 14 Jul 2003 14:53:21 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David griego <dagriego@hotmail.com>, alan@storlinksemi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Message-ID: <20030714215321.GA22061@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com> <1058214842.606.151.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058214842.606.151.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 14 2003, at 21:34, Alan Cox was caught saying:
> 
> You don't have to. You can go build and test and maintain a set of TOE patches.
> Nobody is stopping you. Lots of Linux code exists because someone decided that
> the official story was wrong and proved it so.

Alan,

I agree with your basic sentiment, but the issue here is that supporting
TOE requires changes that are very intimate to the kernel. This is not
like developing I2O which is an edge driver layer, but a core portion
of the kernel.  Some support from the community is going to be needed. 
Currently, any time someone mentions the idea of discussing a TOE 
interface, it's shot down as being evil and bad. 

/me thinks that the HW vendors that really want TOE support need
 to fund some Linux networking folks to go look at the problem
 in detail.

~Deepak

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
