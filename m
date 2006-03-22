Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932860AbWCVWay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbWCVWay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932864AbWCVWay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:30:54 -0500
Received: from ns2.suse.de ([195.135.220.15]:20155 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932860AbWCVWax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:30:53 -0500
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] i386: run BIOS PCI detection before direct
Date: Wed, 22 Mar 2006 22:37:50 +0100
User-Agent: KMail/1.9.1
Cc: Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060317000303.13252107@localhost.localdomain> <200603221410.47505.ak@suse.de> <20060322220817.GA13453@suse.de>
In-Reply-To: <20060322220817.GA13453@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222237.51207.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 23:08, Greg KH wrote:

> 
> Care to send me that copy of the patch so I can forward it on?

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/i386-pci-ordering

-Andi
