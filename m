Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbULKKNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbULKKNa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 05:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbULKKNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 05:13:30 -0500
Received: from picard.ine.co.th ([203.152.41.3]:38278 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261928AbULKKN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 05:13:27 -0500
Subject: Re: kernel (64bit) 4GB memory support
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41BAC68D.6050303@pobox.com>
References: <1102752990.17081.160.camel@cpu0>  <41BAC68D.6050303@pobox.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1102760002.10824.170.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Dec 2004 17:13:22 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-11 at 17:06, Jeff Garzik wrote:
> Rudolf Usselmann wrote:
> > Could anybody tell me which of the previous (non 2.6.9) kernels
> > do support 4GB of main memory in 64 bit mode ?
> 
> 64bit kernels have supported >4GB since their ports inception, AFAIK.
> 
> Your platform could limit this artificially, of course.
> 
> 	Jeff


Yes, but it is currently broken (kernel panics). I wonder
if anybody knew which kernel does work for 64 bit and >4GB
of memory. I'm sure there must be people out there with
similar configurations to mine ....

Thanks,
rudi
(Tiger K8W, dual Opteron)

