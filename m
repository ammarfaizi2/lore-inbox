Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbVKHXtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbVKHXtc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVKHXtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:49:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:1958 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030409AbVKHXtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:49:31 -0500
Date: Tue, 8 Nov 2005 17:49:11 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] PCI Error Recovery 
Message-ID: <20051108234911.GC19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg,

Following seven patches implement the PCI error reporting and recovery
header and device driver changes as recently discussed, w/all requested
changes & etc. These are tested and wrk well.  Please apply.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--linas
