Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbUDGW1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDGW1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:27:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6583 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261197AbUDGW1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:27:49 -0400
Date: Wed, 07 Apr 2004 15:39:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-ID: <6560000.1081377557@flay>
In-Reply-To: <20040408001629.2ff39598.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis><20040407145130.4b1bdf3e.akpm@osdl.org> <20040408001629.2ff39598.ak@suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ppc64+CONFIG_NUMA compiles OK.
> 
> ppc64 doesn't have the system calls hooked up, but I'm not sure how useful
> it would be for these boxes anyways (afaik they are pretty uniform) 

They actually are fairly keen on doing NUMA for HPC stuff - it makes
a significant performance improvement ...

M.

