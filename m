Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVK1FOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVK1FOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 00:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVK1FOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 00:14:07 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:19169 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751238AbVK1FOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 00:14:06 -0500
Date: Mon, 28 Nov 2005 10:41:25 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
Message-ID: <20051128051124.GA3849@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20051122130754.GL32512@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122130754.GL32512@vanheusden.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 02:07:54PM +0100, Folkert van Heusden wrote:

> the stacktrace. The crash dump patches mentioned in oops-tracing.txt all
> don't work for 2.6.14 it seems. So: what should I do? Get my digicam and

could you try kdump (Documentation/kdump/kdump.txt) to capture the crash 
dump. It is part of mainline kernel atleast for i386 architecture. It 
should work for 2.6.14 also.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
