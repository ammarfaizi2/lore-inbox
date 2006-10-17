Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWJQNN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWJQNN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWJQNN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:13:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17037 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750888AbWJQNN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:13:26 -0400
Subject: Re: Most stable kernel for mpich2 cluster?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christopoulos Panagiotis <pxrist@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200610171430.01032.pxrist@gmail.com>
References: <200610171430.01032.pxrist@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 14:40:23 +0100
Message-Id: <1161092423.24237.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-17 am 14:30 +0300, ysgrifennodd Christopoulos
Panagiotis:
> decide the best version. 2.6.18.1 is out but I think that it' s not a good 
> idea to install the latest kernel, so, I would like to tell me your 
> opinion(eg, I think debian is using 2.6.8(too old!)).
> What would you do?	

The older kernels shipped by vendors are not "vanilla source" because
that would lack all the bug and security fixing done. 

Alan

