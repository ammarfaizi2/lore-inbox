Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVILSvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVILSvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVILSvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:51:25 -0400
Received: from colin.muc.de ([193.149.48.1]:4868 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932151AbVILSvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:51:24 -0400
Date: 12 Sep 2005 20:51:20 +0200
Date: Mon, 12 Sep 2005 20:51:20 +0200
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-ID: <20050912185120.GA78614@muc.de>
References: <20050908053042.6e05882f.akpm@osdl.org> <201750000.1126494444@[10.10.2.4]> <20050912050122.GA3830@muc.de> <150330000.1126548402@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150330000.1126548402@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Crashes on boot
> 
> http://test.kernel.org/12589/debug/console.log
> 
> May or may not be anything to do with what you were doing.

Easily tested by reverting dma32*. Does it help?

-Andi
