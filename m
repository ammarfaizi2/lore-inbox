Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272314AbTHNMHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272315AbTHNMHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:07:38 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:24513 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272314AbTHNMHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:07:37 -0400
Date: Thu, 14 Aug 2003 13:06:57 +0100
From: Dave Jones <davej@redhat.com>
To: Nicolai Haehnle <prefect_@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGPv3 command parsing
Message-ID: <20030814120657.GL12953@redhat.com>
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

Already applied to agpgart repository last week, and Linus pulled
a few hours ago. Thanks again.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
