Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbWCIQap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWCIQap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWCIQap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:30:45 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:9151 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932663AbWCIQao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:30:44 -0500
Message-ID: <441057D4.6030304@cfl.rr.com>
Date: Thu, 09 Mar 2006 11:29:08 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Luke-Jr <luke@dashjr.org>
CC: Anshuman Gholap <anshu.pg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> <200603091509.06173.luke@dashjr.org>
In-Reply-To: <200603091509.06173.luke@dashjr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2006 16:33:02.0521 (UTC) FILETIME=[2289B290:01C64397]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14313.000
X-TM-AS-Result: No--1.750000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:
> Or Linux can remain GPL'd, which prohibits binary drivers *legally*, and back 
> this by keeping a non-stable API which prohibits binary drivers 
> *technically*.

If binary drivers are illegal, then why have ATI and nvidia not been 
sued yet?

Interacting with the kernel does not make your software a derived work. 
  A derived work is if you make your own kernel that is very close to a 
straight copy of the Linux kernel.  The right to create new works that 
interact with others ( and therefore, require some understanding of how 
the other work operates ) is specifically protected by the US copyright 
act.

This is why it is legal to reverse engineer a binary driver to gain an 
understanding of how the hardware operates, publish that information, 
and then use that information to create new software to operate that 
hardware.


