Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275273AbTHSBFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275271AbTHSBFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:05:49 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:55238 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275268AbTHSBFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:05:43 -0400
Date: Tue, 19 Aug 2003 02:04:57 +0100
From: Dave Jones <davej@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-ID: <20030819010457.GG22433@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Mackall <mpm@selenic.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20030815101856.3eb1e15a.rddunlap@osdl.org> <20030815173246.GB9681@redhat.com> <20030815123053.2f81ec0a.rddunlap@osdl.org> <20030816070652.GG325@waste.org> <20030818140729.2e3b02f2.rddunlap@osdl.org> <20030819001316.GF22433@redhat.com> <20030819010119.GF16387@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819010119.GF16387@waste.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:01:19PM -0500, Matt Mackall wrote:
 > > 
 > > By the looks of the logs, it happened as I restarted X, as theres
 > > a bunch of mtrr messages right after this..
 > 
 > What video driver do you use?

mga

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
