Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268957AbUIRRqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268957AbUIRRqq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269597AbUIRRqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 13:46:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11743 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269610AbUIRRq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 13:46:28 -0400
Date: Sat, 18 Sep 2004 11:02:43 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial patch for 2.4: resolve megaraid_info name collision
Message-ID: <20040918140243.GB3435@logos.cnet>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409172155.29561.vda@port.imtp.ilyichevsk.odessa.ua> <200409181657.23833.vda@port.imtp.ilyichevsk.odessa.ua> <200409181702.35550.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409181702.35550.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 05:03:12PM +0300, Denis Vlasenko wrote:
> I'm not sure whether it make sense to compile in
> megaraid and megaraid2 at once, 

It doesnt.

> but it does not build without this patch.

Its intentional.




