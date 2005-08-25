Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVHYOq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVHYOq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVHYOq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:46:58 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:44133 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750932AbVHYOq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:46:58 -0400
X-IronPort-AV: i="3.96,141,1122872400"; 
   d="scan'208"; a="284745383:sNHT25629180"
Date: Thu, 25 Aug 2005 10:02:29 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc6] dcdbas: add Dell Systems Management Base Driver with sysfs support
Message-ID: <20050825150229.GA5848@sysman-doug.us.dell.com>
References: <20050825020021.GA5223@sysman-doug.us.dell.com> <20050825030909.GB6079@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825030909.GB6079@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 08:09:09PM -0700, Chris Wedgwood wrote:
> On Wed, Aug 24, 2005 at 09:00:21PM -0500, Doug Warzecha wrote:
> 
> [...]
> 
> > +Dell OpenManage requires this driver on the following Dell PowerEdge systems:
> > +300, 1300, 1400, 400SC, 500SC, 1500SC, 1550, 600SC, 1600SC, 650, 1655MC,
> > +700, and 750.  Other Dell software such as the open source Libsmbios library
> > +is expected to make use of this driver, and it may include the use of this
> > +driver on other Dell systems.
> 
> I'd like to see a URL/pointer somewhere about here in the docs for the
> location of libsmbios if nobody objects.

No objections.  I'll add it.

Doug
