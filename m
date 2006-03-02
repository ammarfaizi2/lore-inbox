Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWCBPg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWCBPg4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWCBPg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:36:56 -0500
Received: from fsmlabs.com ([168.103.115.128]:51850 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750823AbWCBPgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:36:55 -0500
X-ASG-Debug-ID: 1141313808-28564-128-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 2 Mar 2006 07:41:13 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: jensmh@gmx.de
cc: linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: 2.6.16-rc5 'lost' cpu
Subject: Re: 2.6.16-rc5 'lost' cpu
In-Reply-To: <200603020505.13108.jensmh@gmx.de>
Message-ID: <Pine.LNX.4.64.0603020734200.28074@montezuma.fsmlabs.com>
References: <200603020505.13108.jensmh@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9345
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, jensmh@gmx.de wrote:

> This is a dual xeon system with hyper threading enabled, so there should
> be 4 cpus
> 
> jm@voyager ~ $ ll /proc/acpi/processor/
> total 0
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU0
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU1
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU3

Can you try sending dmesg output too?
