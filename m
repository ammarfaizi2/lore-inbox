Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbUBXTNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbUBXTNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:13:50 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:18365 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262398AbUBXTNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:13:43 -0500
Date: Tue, 24 Feb 2004 13:12:14 -0600 (CST)
From: Pat Gefre <pfg@sgi.com>
To: Greg KH <greg@kroah.com>
cc: Pat Gefre <pfg@sgi.com>, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix hotplug
In-Reply-To: <20040223202313.GA22207@kroah.com>
Message-ID: <Pine.SGI.3.96.1040224131106.43293E-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Greg KH wrote:

+ On Mon, Feb 23, 2004 at 08:55:14AM -0600, Pat Gefre wrote:
+ > 
+ > 2.6 Altix patch for kernel hotplug support
+ 
+ You mean "PCI hotplug support" right?

Yes.


+ 
+ If so, how?  I do not see a single call to pci_hp_register() or friends
+ here.  What is the userspace interface to your pci hotplug system?
+ 

We have a hotplug driver - not included in this update - this is just
the kernel code.

-- Pat

