Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUGHPZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUGHPZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUGHPZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:25:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:55012 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264129AbUGHPZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:25:02 -0400
Date: Thu, 8 Jul 2004 10:24:25 -0500
From: linas@austin.ibm.com
To: Greg KH <greg@kroah.com>
Cc: Linda Xie <lxiep@us.ibm.com>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040708102425.L21634@forte.austin.ibm.com>
References: <20040707155907.G21634@forte.austin.ibm.com> <40EC9A02.1000507@us.ibm.com> <20040707190642.J21634@forte.austin.ibm.com> <20040708060933.GE548@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040708060933.GE548@kroah.com>; from greg@kroah.com on Wed, Jul 07, 2004 at 11:09:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 11:09:33PM -0700, Greg KH wrote:
> > pci_scan_child_bus() is currently ...
>
> It's in the latest -bk tree, right?

yes, it looks correct in the current tree (it wasn't when 
I'd previously cloned).    It's possible I'm not using bk correctly;
once I've modified a file, 'bk pull' never merges in newer changes 
made upstream.  So I have to 'bk clone' all the time, which is a 
pain in the neck. What am I doing wrong?

--linas
