Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269255AbUINKEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269255AbUINKEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269249AbUINKEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:04:46 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:65468 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S269276AbUINKCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:02:53 -0400
Date: Tue, 14 Sep 2004 13:02:42 +0300 (EEST)
From: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
X-X-Sender: midian@midi.ihme.net
To: karthi n <linuxkarthi@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: QM_MODULES
In-Reply-To: <3ed7d0be0409140056545639ec@mail.gmail.com>
Message-ID: <20040914130156.N4672@midi.ihme.net>
References: <3ed7d0be0409140056545639ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, karthi n wrote:

> hai,
>          i am new to this list, while i boot the box with newly
> complied kernel 2.6.8-1, i lost my network connection, err msg is
>
> "ifup: QM_MODULES: Function not implemented"
>
> in somany places, can you help me to solve this issue,
>
Install module-init-tools on your box, that will make the modules work 
again.

 	Markus
