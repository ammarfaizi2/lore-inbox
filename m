Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbTIDDoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbTIDDoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:44:37 -0400
Received: from holomorphy.com ([66.224.33.161]:53132 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264634AbTIDDof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:44:35 -0400
Date: Wed, 3 Sep 2003 20:45:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Larry McVoy <lm@bitmover.com>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030904034513.GD1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Lang <david.lang@digitalinsight.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, "Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
References: <9110000.1062643682@[10.10.2.4]> <Pine.LNX.4.44.0309032004120.17581-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309032004120.17581-100000@dlang.diginsite.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:16:16PM -0700, David Lang wrote:
> some of these problems can be addressed in hardware (the Opteron could be
> called SSI-NUMA that has it's partitioning layer running in hardware
> for up to 8 CPU's) but addressing it in hardware runs into scaling
> problems becouse you don't want to pay to much at the low end for the
> features you need on the high end (which is why the opteron doesn't
> directly scale to 128+ CPU's in one image)

Most of those features are just methods of connecting hardware
components.


-- wli
