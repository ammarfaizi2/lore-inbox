Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVC3VAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVC3VAC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVC3U6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:58:40 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18610 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261577AbVC3U5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:57:36 -0500
Date: Wed, 30 Mar 2005 12:56:29 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: jlan@engr.sgi.com, guillaume.thouvenin@bull.net, akpm@osdl.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050330125629.66963bc6.pj@engr.sgi.com>
In-Reply-To: <20050330181412.B13722@2ka.mipt.ru>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112079856.5243.24.camel@uganda>
	<20050329004915.27cd0edf.pj@engr.sgi.com>
	<1112092197.5243.80.camel@uganda>
	<20050329090304.23fbb340.pj@engr.sgi.com>
	<4249C418.5040007@engr.sgi.com>
	<20050329140106.2a9b8aa5.pj@engr.sgi.com>
	<20050330181412.B13722@2ka.mipt.ru>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So it still can be used for accounting :)

No ... so these results don't show that it shouldn't be used for
accounting.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
