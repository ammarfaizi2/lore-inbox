Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSJYNZr>; Fri, 25 Oct 2002 09:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbSJYNZr>; Fri, 25 Oct 2002 09:25:47 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:6086 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261397AbSJYNZq>; Fri, 25 Oct 2002 09:25:46 -0400
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Nyk Tarr <nyk@giantx.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021025103938.GN4153@suse.de>
References: <20021025103631.GA588@giantx.co.uk> 
	<20021025103938.GN4153@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 14:49:24 +0100
Message-Id: <1035553765.13244.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 11:39, Jens Axboe wrote:
> 2.5.44 and thus 2.5.44-acX has seriously broken REQ_BLOCK_PC, so it's no
> wonder that it breaks hard. Alan, I can sync the sgio patches for you if
> you want.

Please do

