Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTKMIAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 03:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTKMIAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 03:00:11 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:20888 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262120AbTKMIAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 03:00:09 -0500
Message-ID: <3FB33A7C.1010601@stesmi.com>
Date: Thu, 13 Nov 2003 09:02:04 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cory Bell <cory.bell@usa.net>
CC: linux-kernel@vger.kernel.org,
       Joe Harrington <jh@oobleck.astro.cornell.edu>
Subject: Re: Via KT600 support?
References: <1068657190.4255.21.camel@homer.oit.pdx.edu>
In-Reply-To: <1068657190.4255.21.camel@homer.oit.pdx.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One caveat: It appears that the kernel included with FC1 was not
> compiled with the same version of gcc that is included in FC1. This
> means you will need to compile your own kernel (or rebuild the FC1
> kernel SRPM). I got an instant panic when trying to insert a
> locally-compiled sk98lin module into the supplied kernel, so I just
> downloaded the latest 2.4.23 test release.

Install the gcc32 rpm and compile the kernel with CC=gcc32 instead.

// Stefan

