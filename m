Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbSJAVBT>; Tue, 1 Oct 2002 17:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262303AbSJAVBT>; Tue, 1 Oct 2002 17:01:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18705 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262272AbSJAVBT>;
	Tue, 1 Oct 2002 17:01:19 -0400
Message-ID: <3D9A0E46.3070608@pobox.com>
Date: Tue, 01 Oct 2002 17:06:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
References: <Pine.LNX.4.44.0210012022150.13515-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the risk of being on-topic <g>, would it be reasonable to request a 
2.4 version of this patch, that can be used in driver-compat code and 
vendor kernels?  i.e. something that makes the workqueue API work in 
2.4, no more, no less.

	Jeff



