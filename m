Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUBYRQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUBYRQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:16:14 -0500
Received: from terminus.zytor.com ([63.209.29.3]:7633 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S261467AbUBYRQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:16:10 -0500
Message-ID: <403CD852.1060200@zytor.com>
Date: Wed, 25 Feb 2004 09:16:02 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA2718@scsmsx402.sc.intel.com> <403CCBE0.7050100@techsource.com> <c1ihqh$e0r$1@terminus.zytor.com> <403CD900.6080003@techsource.com>
In-Reply-To: <403CD900.6080003@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> I think we were talking about absolute branches when referring to "near 
> branches".  For absolute branches, having a 32-bit address restricts you 
> to the lower 4G of the address space.
> 

You're talking about *indirect* near branches?  Those are the only 
absolute near branches which exist...

	-hpa
