Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRDJPGF>; Tue, 10 Apr 2001 11:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDJPFp>; Tue, 10 Apr 2001 11:05:45 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:50194 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132147AbRDJPFn>; Tue, 10 Apr 2001 11:05:43 -0400
Message-Id: <200104101505.f3AF5bs31859@aslan.scsiguy.com>
To: Giuliano Pochini <pochini@denise.shiny.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx driver problems 
In-Reply-To: Your message of "Tue, 03 Apr 2001 23:34:49 +0200."
             <3ACA41F9.FCC07369@denise.shiny.it> 
Date: Tue, 10 Apr 2001 09:05:37 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I have two Adaptec 2930CU (ultra narrow) cards. I modified the driver to
>make them work in ultra mode.

Can you elaborate on what you had to modify?

>Apr  3 23:05:10 Jay kernel: scsi1:0:4:0: Attempting to queue an ABORT message 

Please run your system with aic7xxx=verbose and send me the resulting
messages.  You should also upgrade to v6.1.11 of the driver.

--
Justin
