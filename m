Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268927AbUHMBVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268927AbUHMBVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUHMBVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:21:37 -0400
Received: from apollo.tuxdriver.com ([24.172.12.4]:35858 "EHLO
	ra.tuxdriver.com") by vger.kernel.org with ESMTP id S268924AbUHMBV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:21:27 -0400
Message-ID: <411C17B4.7030804@tuxdriver.com>
Date: Thu, 12 Aug 2004 21:21:56 -0400
From: "John W. Linville" <linville@tuxdriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: Re: [patch] 2.6 -- add IOI Media Bay to SCSI quirk list
References: <200408122137.i7CLbGU13688@ra.tuxdriver.com> <20040812225118.GA20904@beaverton.ibm.com> <411BF6A5.2030306@tuxdriver.com> <20040813002756.GA21763@beaverton.ibm.com>
In-Reply-To: <20040813002756.GA21763@beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:

>Only add borken devices to the list, so it is a list of bad devices rather
>than a list of good ones.
>  
>

I now see the comments about the list being deprecated.  I withdraw the 
2.6 patch.  I still think the 2.4 patch is wortwhile, unless there is an 
overhaul going-on there as well.

John
