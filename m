Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVEJTmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVEJTmh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVEJTmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:42:37 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:54703 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261760AbVEJTmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:42:31 -0400
Date: Tue, 10 May 2005 12:42:25 -0700
From: mike kravetz <kravetz@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: jschopp@austin.ibm.com, akpm@osdl.org, anton@samba.org,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linuxppc64-dev@ozlabs.org, olof@lixom.net, paulus@samba.org
Subject: Re: sparsemem ppc64 tidy flat memory comments and fix benign mempresent call
Message-ID: <20050510194225.GD3915@w-mikek2.ibm.com>
References: <E1DVAVE-00012m-Pq@pinky.shadowen.org> <427FEC57.8060505@austin.ibm.com> <4280D72C.4090203@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4280D72C.4090203@shadowen.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 04:45:48PM +0100, Andy Whitcroft wrote:
> Joel, Mike, Dave could you test this one on your platforms to confirm
> its widly applicable, if so we can push it up to -mm.

It works on my machine with various config options.

-- 
Mike
