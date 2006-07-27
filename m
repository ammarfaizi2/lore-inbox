Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWG0QYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWG0QYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWG0QYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:24:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29570 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750811AbWG0QYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:24:01 -0400
Date: Thu, 27 Jul 2006 12:23:53 -0400
From: Dave Jones <davej@redhat.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Create IP100A Driver
Message-ID: <20060727162353.GF5687@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesse Huang <jesse@icplus.com.tw>, linux-kernel@vger.kernel.org
References: <1154029172.5967.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154029172.5967.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 03:39:32PM -0400, Jesse Huang wrote:
 > From: Jesse Huang <jesse@icplus.com.tw>
 > 
 > This is the first version of IP100A Linux Driver.

This driver is 99% the same as drivers/net/sundance.c, which
already implements support for the PCI IDs your cards use.

Could you send diffs relative to that driver please ?

Thanks,

		Dave

-- 
http://www.codemonkey.org.uk
