Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTKMIOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 03:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTKMIOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 03:14:32 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:33432 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262123AbTKMIOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 03:14:31 -0500
Message-ID: <3FB33DE3.8020304@stesmi.com>
Date: Thu, 13 Nov 2003 09:16:35 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Cory Bell <cory.bell@usa.net>, linux-kernel@vger.kernel.org,
       Joe Harrington <jh@oobleck.astro.cornell.edu>
Subject: Re: Via KT600 support?
References: <1068657190.4255.21.camel@homer.oit.pdx.edu> <3FB33A7C.1010601@stesmi.com>
In-Reply-To: <3FB33A7C.1010601@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:

> 
>> One caveat: It appears that the kernel included with FC1 was not
>> compiled with the same version of gcc that is included in FC1. This
>> means you will need to compile your own kernel (or rebuild the FC1
>> kernel SRPM). I got an instant panic when trying to insert a
>> locally-compiled sk98lin module into the supplied kernel, so I just
>> downloaded the latest 2.4.23 test release.
> 
> 
> Install the gcc32 rpm and compile the kernel with CC=gcc32 instead.
> 
> // Stefan

That is, compile the driver you want compiled that way.

// Stefan

