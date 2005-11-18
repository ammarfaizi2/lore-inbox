Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030610AbVKRKKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbVKRKKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 05:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030611AbVKRKKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 05:10:30 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:54402 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030610AbVKRKKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 05:10:30 -0500
Subject: Re: 2.6.15-rc1-mm2
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051117234645.4128c664.akpm@osdl.org>
References: <20051117234645.4128c664.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 18 Nov 2005 08:10:24 -0200
Message-Id: <1132308624.27425.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-3mdk 
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2005-11-17 às 23:46 -0800, Andrew Morton escreveu:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm2/
> 
> 
> - I'm releasing this so that Hugh's MM rework can get a spin.
> 
>   Anyone who had post-2.6.14 problems related to the VM_RESERVED changes
>   (device drivers malfunctioning, obscure userspace hardware-poking
>   applications stopped working, etc) please test.
> 
>   We'd especially like testing of the graphics DRM drivers across as many
>   card types as poss.
	Also V4L users should test. We had lots of complain or malfunctioning
on x32 and non-functioning on x64 archtectures that seems to be related
to VM_RESERVED.
> 

Cheers, 
Mauro.

