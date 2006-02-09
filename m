Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWBIGEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWBIGEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbWBIGEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:04:36 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:223 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1422810AbWBIGEf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:04:35 -0500
Date: Thu, 09 Feb 2006 01:06:09 -0500
From: Jon Ringle <jringle@vertical.com>
Subject: Linux running on a PCI Option device?
To: linux-kernel@vger.kernel.org
Message-id: <200602090106.10411.jringle@vertical.com>
Organization: Vertical
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.9.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am working on a new board that will have Linux running on an xscale 
processor. This board will be a PCI Option device. I currently have a IXDP465 
eval board which has a PCI Option connector that I will use for prototyping. 
>From what I can tell so far, Linux wants to scan the PCI bus for devices as 
if it is the PCI host. Is there any provision in Linux so that it can take on 
the role of a PCI option rather than a PCI host?

Jon

PS. Please CC me on replies.
