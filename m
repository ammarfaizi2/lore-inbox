Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbUDGXBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDGXBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:01:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:42721 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264210AbUDGW5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:57:53 -0400
Date: Wed, 07 Apr 2004 16:09:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-ID: <18500000.1081379365@flay>
In-Reply-To: <20040407155225.14936e8a.akpm@osdl.org>
References: <1081373058.9061.16.camel@arrakis><20040407145130.4b1bdf3e.akpm@osdl.org><5840000.1081377504@flay><20040408003809.01fc979e.ak@suse.de> <20040407155225.14936e8a.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sizeof(vm_area_struct) is a very sensitive thing on ia32.  If you expect
> that anyone is likely to actually use the numa API on 32-bit, sharing

Me please ;-)

M.

