Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUD2UUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUD2UUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUD2UUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:20:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:33681 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264501AbUD2UUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:20:34 -0400
Date: Thu, 29 Apr 2004 13:18:28 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nick Piggin <nickpiggin@yahoo.com.au>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell 
Message-ID: <81920000.1083269908@flay>
In-Reply-To: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
References: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, April 29, 2004 16:01:11 -0400 Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

> Nick Piggin <nickpiggin@yahoo.com.au> said:
> 
> [...]
> 
>> I don't know. What if you have some huge application that only
>> runs once per day for 10 minutes? Do you want it to be consuming
>> 100MB of your memory for the other 23 hours and 50 minutes for
>> no good reason?
> 
> How on earth is the kernel supposed to know that for this one particular
> job you don't care if it takes 3 hours instead of 10 minutes, just because
> you don't want to spare enough preciousss RAM?

Nice value is the obvious interface for such information.

M.

