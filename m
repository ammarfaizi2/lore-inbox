Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUKCVoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUKCVoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKCVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:40:46 -0500
Received: from pyxis.pixelized.ch ([213.239.200.113]:40908 "EHLO
	pyxis.pixelized.ch") by vger.kernel.org with ESMTP id S261917AbUKCVhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:37:22 -0500
Message-ID: <41894F86.7070405@debian.org>
Date: Wed, 03 Nov 2004 22:37:10 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
References: <41894779.10706@techsource.com> <20041103211714.GP12275@mea-ext.zmailer.org>
In-Reply-To: <20041103211714.GP12275@mea-ext.zmailer.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> On Wed, Nov 03, 2004 at 04:02:49PM -0500, Timothy Miller wrote:
> 
>>I'm just curious about why there seems to be so much work going into 
>>supporting a wide range of GCC versions.  If people are willing to 
>>download and compile a new kernel (and migrating from 2.4 to 2.6 is 
>>non-trivial for some systems, like RH9), why aren't they willing to also 
>>download and build a new compiler?
> 
> 
> 
> How about those other architectures, than i386 ?
> Over the years I have learned, that while GCC may work OK in i386,
> the same version used in SPARC does produce bad code.  This has
> bitten me multiple times.
> 
> 
> We weird people of other architechtures do tend to get "somewhat"
> conservative over the years in finding, and finally staying with
> a compiler that we have learned to work.   Multiple burned,
> forever shy...

But is it Linux the biggest compiler bug finder?
So forcing a newer compiler in other architectures should
improve also the quality of code generation.

ciao
	cate
