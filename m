Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVCJRCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVCJRCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVCJQ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:56:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10193 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262787AbVCJQy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:54:56 -0500
Date: Thu, 10 Mar 2005 08:54:12 -0800
From: mike kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 NUMA memory fixup
Message-ID: <20050310165412.GA6356@w-mikek2.ibm.com>
References: <16942.30144.513313.26103@cargo.ozlabs.ibm.com> <20050310023613.23499386.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310023613.23499386.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 02:36:13AM -0800, Andrew Morton wrote:
> 
> This patch causes the non-numa G5 to oops very early in boot in
> smp_call_function().
> 

OK - Let me take a look.

-- 
Mike
