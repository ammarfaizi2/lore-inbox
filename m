Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWCIXuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWCIXuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWCIXuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:50:55 -0500
Received: from mx.pathscale.com ([64.160.42.68]:48520 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750880AbWCIXuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:50:54 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adamzfzdvuo.fsf@cisco.com>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <adalkvjfbo0.fsf@cisco.com>
	 <1141947581.10693.45.camel@serpentine.pathscale.com>
	 <adamzfzdvuo.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:50:53 -0800
Message-Id: <1141948253.10693.50.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:47 -0800, Roland Dreier wrote:

> That's fine.  So then I guess the question is, why can't you use your
> SMA all the time?

We do.  It coexists with OpenSM if OpenSM is present.

	<b

