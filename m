Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262845AbSJAWLk>; Tue, 1 Oct 2002 18:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262848AbSJAWLk>; Tue, 1 Oct 2002 18:11:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17426 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262845AbSJAWLj>;
	Tue, 1 Oct 2002 18:11:39 -0400
Message-ID: <3D9A1EC2.2020706@pobox.com>
Date: Tue, 01 Oct 2002 18:16:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mau <mau@oscar.prima.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LMbench results for 2.5.40
References: <20021001220853.GA20022@oscar.dorf.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mau wrote:
> Hallo,
> 
> these are LMbench results for 2.4.18 and 2.5.40 (two runs).
> All results where obtained in single-user mode after a fresh
> reboot.
> 
> 2.5.40 was compiled with CONFIG_PREEMPT=n.
> 
> Could someone explain the results I marked with '???' ?
> The ones under 'Local Communication Bandwidth'.


any chance you can run each set of tests three times?  (I know it takes 
longer, but it's better for statistical purposes...)

