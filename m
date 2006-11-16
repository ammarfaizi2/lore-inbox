Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423918AbWKPMuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423918AbWKPMuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 07:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423930AbWKPMun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 07:50:43 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:57888 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1423918AbWKPMun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 07:50:43 -0500
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=cU2Re4i52NRoqfwgnE+QixxqIuuOhxGk9VC3QCLBDNPp3pb4TJbdxvY+w4Ko98/0oiqOmYBTiR700k9qHCkxrByX0mwVYOYMbs9L9o8i4HSZvclP3gqGFeHUvBGtsRwr;
X-IronPort-AV: i="4.09,428,1157346000"; 
   d="scan'208"; a="136590668:sNHT119522844"
Date: Thu, 16 Nov 2006 06:50:39 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] make arch/i386/pci/common.c:pci_bf_sort static
Message-ID: <20061116125038.GB7715@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20061116121623.GE31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116121623.GE31879@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 01:16:23PM +0100, Adrian Bunk wrote:
> This patch makes the needlessly global pci_bf_sort static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
