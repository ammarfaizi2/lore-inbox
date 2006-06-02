Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWFBQ7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWFBQ7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 12:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWFBQ7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 12:59:12 -0400
Received: from mga05.intel.com ([192.55.52.89]:8832 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932517AbWFBQ7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 12:59:11 -0400
X-IronPort-AV: i="4.05,204,1146466800"; 
   d="scan'208"; a="46076659:sNHT696992142"
Date: Fri, 2 Jun 2006 09:50:38 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Rajesh Shah <rajesh.shah@intel.com>, "bibo,mao" <bibo.mao@intel.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
Message-ID: <20060602095037.A11014@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <20060602044221.GB1501@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060602044221.GB1501@colo.lackof.org>; from grundler@parisc-linux.org on Thu, Jun 01, 2006 at 10:42:21PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 10:42:21PM -0600, Grant Grundler wrote:
> this to work right.  The vast majority of BIOS's do get it right
> and that's why I'm not terribly worried.
> 
> If there is consensus the drivers are wrong, then it's pretty
> easy to fix and we don't have to panic.
> 
> Do you agree with the change in the text?
> 
Yeah, I agree that's the right order. 

Rajesh
