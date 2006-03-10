Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752091AbWCJAEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbWCJAEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbWCJAEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:04:35 -0500
Received: from mx.pathscale.com ([64.160.42.68]:3978 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752091AbWCJAEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:04:35 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <ada64mndv8m.fsf@cisco.com>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <ada8xrjfbd8.fsf@cisco.com>
	 <1141948367.10693.53.camel@serpentine.pathscale.com>
	 <ada64mndv8m.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 16:04:34 -0800
Message-Id: <1141949074.10693.65.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 16:00 -0800, Roland Dreier wrote:
>     Bryan> We don't support hotplugged devices at the moment.
> 
> How do you stop someone from hot plugging a PCIe device?

You say "we don't support this yet" somewhere in big letters.  The chips
and cards support hotplug electrically and logically.  We just haven't
had time yet to do the driver support work, and won't for a while.

	<b

