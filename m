Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVBYQth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVBYQth (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 11:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVBYQte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 11:49:34 -0500
Received: from dialpool3-191.dial.tijd.com ([62.112.12.191]:6058 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262740AbVBYQs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 11:48:28 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.8.1 to linux-2.6.10: Kernel Patching Issues.
Date: Fri, 25 Feb 2005 17:48:42 +0100
User-Agent: KMail/1.7.2
References: <Pine.LNX.4.10.10502251550520.26208-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10502251550520.26208-100000@mtfhpc.demon.co.uk>
Cc: Mark Fortescue <mark@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502251748.43447.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 February 2005 17:40, Mark Fortescue wrote:
> Hi all,
>
> I am not sure exactly where to send this email. A have chosen the
> ip4/ip6 networking as the issues are in this area of the kernel.
>
> The kernel patch files patch-2.6.9 and patch-2.6.10 do not apear to be
> correct. I had some errors during patching so I generated a diff against a
> freshly downloaded linux-2.6.10 kernel. See the steps below:

You first have to go back to kernel 2.6.8, and then patch upwards to 2.6.9 and 
2.6.10. Don't patch upwards from 2.6.8.1.

Jan

-- 
It's better to burn out than to fade away.
