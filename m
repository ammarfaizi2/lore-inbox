Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTIYWBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 18:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTIYWBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 18:01:48 -0400
Received: from aneto.able.es ([212.97.163.22]:40404 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261901AbTIYWBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 18:01:46 -0400
Date: Fri, 26 Sep 2003 00:01:43 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel PRO/1000 NIC
Message-ID: <20030925220143.GE7919@werewolf.able.es>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010124F04A@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010124F04A@orsmsx402.jf.intel.com> (from scott.feldman@intel.com on Mon, Sep 15, 2003 at 22:04:14 +0200)
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.15, "Feldman, Scott" wrote:
> > I am sending UDP data from one PC to another PC directly 
> > through a cross cable. The NIC of sender is Intel(r) PRO/1000 
> > MT Server Adapter, and the NIC of receiver is on-board Intel 
> > PRO/1000 (Dell PowerEdge 1600SC).
> 
> A dump of lspci -vvv, ethtool -i eth<x>, and ethtool -d eth<x> will tell
> us the 8254x controller version you're using; the driver version; if
> you're running PCI or PCI-X, and at what speed; and what you're sharing
> the bus with.
> 
> Ethtool version 1.8: http://sf.net/projects/gkernel.
> Latest e1000: http://sf.net/projects/e1000.
> 

Are there any patches available for 2.4 without all the compat things ?

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre5-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
