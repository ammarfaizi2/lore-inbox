Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271090AbTHGXRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271116AbTHGXRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:17:51 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:30144 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S271090AbTHGXRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:17:50 -0400
Date: Fri, 8 Aug 2003 00:16:58 +0100
From: Dave Jones <davej@redhat.com>
To: Nicolai Haehnle <prefect_@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGPv3 command parsing
Message-ID: <20030807231658.GA26856@suse.de>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nicolai Haehnle <prefect_@gmx.net>, linux-kernel@vger.kernel.org
References: <200308080321.10691.prefect_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308080321.10691.prefect_@gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 03:21:04AM +0200, Nicolai Haehnle wrote:

 > there's a trivial but fatal typo in agp/generic.c:agp_v3_parse_one() that 
 > completely messes up the command generation.
 > 
 > I'll let the attached patch against 2.6.0 explain the rest...

Whoops. Thanks, applied.

		Dave

