Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUCVQe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUCVQe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:34:59 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:1551 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262092AbUCVQe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:34:56 -0500
Message-ID: <405F19A3.20001@techsource.com>
Date: Mon, 22 Mar 2004 11:51:47 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Tigran Aivazian <tigran@veritas.com>,
       David Schwartz <davids@webmaster.com>,
       Justin Piszcz <jpiszcz@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
References: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet> <405F0B8D.8040408@techsource.com> <Pine.LNX.4.53.0403221057400.17797@chaos>
In-Reply-To: <Pine.LNX.4.53.0403221057400.17797@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

> 
> ALL instructions are performed by the microcode. 

The Z80 had no microcode.  It was completely hard-wired.

As I understand it, it's pretty much an ancient idea to do "everything" 
by microcode.  Only certain very complex instructions are done by microcode.

On the other hand, as I said before, it's not unreasonable for lookup 
tables to be involved in instruction decoding.

