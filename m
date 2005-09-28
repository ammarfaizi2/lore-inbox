Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbVI1AgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbVI1AgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVI1AgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:36:13 -0400
Received: from mail0.lsil.com ([147.145.40.20]:51448 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751166AbVI1AgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:36:12 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C0438823C@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into 
	the kernel
Date: Tue, 27 Sep 2005 18:28:33 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 27, 2005 4:51 PM, Luben Tuikov wrote:

> Christoph's code is
>  * MPT based only,
>  * doesn't follow a spec to save its life,
>  * far inferior in SAS capabilities and SAS representation
>    again, due to the fact that it is MPT based.
> 
> Since the whole point of MPT is to _hide_ the transport.
> 


Hi Luben,

OK, Man are you alright?

I've heard of other vendors planning to 
provide solutions where sas is implemented
in firmware, similar to MPT.  Christophs
sas layer is going to work with other 
solutions, don't think of it being 
MPT centric.


Later,
Eric Moore 
