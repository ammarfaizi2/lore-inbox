Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbTEFOXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTEFOXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:23:46 -0400
Received: from zero.aec.at ([193.170.194.10]:60426 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263825AbTEFOX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:23:28 -0400
Date: Tue, 6 May 2003 16:35:33 +0200
From: Andi Kleen <ak@muc.de>
To: Matt Bernstein <mb--lkml@dcs.qmul.ac.uk>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>,
       elenstev@mesatop.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
Message-ID: <20030506143533.GA22907@averell>
References: <1051905879.2166.34.camel@spc9.esa.lanl.gov> <20030502133405.57207c48.akpm@digeo.com> <1051908541.2166.40.camel@spc9.esa.lanl.gov> <20030502140508.02d13449.akpm@digeo.com> <1051910420.2166.55.camel@spc9.esa.lanl.gov> <Pine.LNX.4.55.0305030014130.1304@jester.mews> <20030502164159.4434e5f1.akpm@digeo.com> <20030503025307.GB1541@averell> <Pine.LNX.4.55.0305030800140.1304@jester.mews> <Pine.LNX.4.55.0305061511020.3237@r2-pc.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0305061511020.3237@r2-pc.dcs.qmul.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 04:15:55PM +0200, Matt Bernstein wrote:
> Is this helpful?

What I really need is an probably decoded with ksymoops oops, not jpegs.

Also you seem to be the only one with the problem so just to avoid
any weird build problems do a make distclean and rebuild from scratch
and reinstall the modules.

-Andi
