Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUCRVsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbUCRVsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:48:47 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:62592 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S262969AbUCRVsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:48:46 -0500
Message-ID: <405A1900.6020400@lbl.gov>
Date: Thu, 18 Mar 2004 13:47:44 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark <mark@harddata.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon CPU detection..
References: <4059FCB9.4070204@lbl.gov> <200403181352.34737.mark@harddata.com>
In-Reply-To: <200403181352.34737.mark@harddata.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark wrote:
> 
> 
> AFAIK this information comes from the Bios. Some bioses don't verify that the 
> second CPU as being an MP. It's been known for some time. Some people were 
> using this to run 1 MP and 1 XP to save money on processors. However if you 
> were to update your bios, it might start checking both for being MPs. 
> Original bioses didn't even check for the first processor at one time but AMD 
> complained and the bioses were modified.
> 

ah, yes, that's right.

I checked - stupid bios.  Thanks!

thomas
