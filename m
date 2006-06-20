Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWFTHct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWFTHct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWFTHct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:32:49 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:18854 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S965126AbWFTHcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:32:48 -0400
Date: Tue, 20 Jun 2006 09:32:34 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] utrace: new modular infrastructure for user debug/tracing
Message-ID: <20060620073234.GA29317@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
References: <20060619105011.31953180049@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619105011.31953180049@magilla.sf.frob.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 03:50:11AM -0700, Roland McGrath wrote:
> I have been working on for a while, and imagining for much longer,
> replacing ptrace from the ground up.  This is what I've come up with so
> far, and I'm looking for some reactions on the direction.  What I'm

Roland,

Is this what has elsewhere been referred to as 'ptrace-ng'?

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
