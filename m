Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422739AbWCWX7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWCWX7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWCWX7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:59:11 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:28846 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1422737AbWCWX7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:59:08 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] DMI: move dmi_scan.c from arch/i386 to drivers/firmware/
Date: Thu, 23 Mar 2006 16:59:02 -0700
User-Agent: KMail/1.8.3
Cc: ak@suse.de, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       hpa@zytor.com, alan@lxorguk.ukuu.org.uk, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, discuss@x86-64.org, pazke@donpac.ru,
       Matt_Domsch@dell.com
References: <200603231337.53657.bjorn.helgaas@hp.com> <200603231408.49675.bjorn.helgaas@hp.com> <20060323155118.17028026.akpm@osdl.org>
In-Reply-To: <20060323155118.17028026.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231659.02735.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 16:51, Andrew Morton wrote:
> I'd expect things to be settled down in a couple of weeks.  Patches which
> move files around are hard.

OK, I'll watch for those merges and try again afterwards.
