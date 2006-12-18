Return-Path: <linux-kernel-owner+w=401wt.eu-S1752165AbWLRDGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbWLRDGw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbWLRDGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:06:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34081 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbWLRDGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:06:51 -0500
Date: Sun, 17 Dec 2006 22:05:42 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20rc1 oops.
Message-ID: <20061218030542.GA12927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061214210215.GC22164@redhat.com> <20061218025710.GS10316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218025710.GS10316@stusta.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 03:57:10AM +0100, Adrian Bunk wrote:
 > On Thu, Dec 14, 2006 at 04:02:15PM -0500, Dave Jones wrote:
 > 
 > > Hmm. Puzzling.
 > 
 > CONFIG_PCI_MULTITHREAD_PROBE=y ?

I pondered that too, and set a kernel building before I left the
office on Friday without it.  Will try booting it when I get
back to it tomorrow.

		Dave

-- 
http://www.codemonkey.org.uk
