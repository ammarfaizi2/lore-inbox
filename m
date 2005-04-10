Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVDJDXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVDJDXY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 23:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVDJDXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 23:23:24 -0400
Received: from ciistr1.ist.utl.pt ([193.136.128.1]:65431 "EHLO
	ciistr1.ist.utl.pt") by vger.kernel.org with ESMTP id S261313AbVDJDXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 23:23:14 -0400
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Processes stuck on D state on Dual Opteron
Date: Sun, 10 Apr 2005 04:22:27 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504100328.53762.ctpm@rnl.ist.utl.pt> <4258950C.1040903@yahoo.com.au>
In-Reply-To: <4258950C.1040903@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504100422.28014.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 10 April 2005 03:53, Nick Piggin wrote:
>
> Looks like you may possibly have a memory allocation deadlock
> (although I can't explain the NMI oops).
>
> I would be interested to see if the following patch is of any
> help to you.
>

  Hi Nick,

  I'll build a kernel with your patch and report on the results as soon as 
possible.

 Thanks 

Claudio

