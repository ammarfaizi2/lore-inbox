Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUDPTUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUDPTUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:20:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22997 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263128AbUDPTUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:20:16 -0400
Message-ID: <408031E2.6040407@pobox.com>
Date: Fri, 16 Apr 2004 15:20:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Ken Ashcraft <ken@coverity.com>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu, scott.feldman@intel.com,
       Ganesh.Venkatesan@intel.com, john.ronciak@intel.com, cramerj@intel.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
References: <1082134916.19301.7.camel@dns.coverity.int> <20040416112051.V22989@build.pdx.osdl.net>
In-Reply-To: <20040416112051.V22989@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The proper solution is for e1000 to use ethtool_ops.



