Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbVAFXet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbVAFXet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVAFXeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:34:22 -0500
Received: from relay03.pair.com ([209.68.5.17]:8967 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S263061AbVAFXdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:33:50 -0500
X-pair-Authenticated: 66.134.112.218
Subject: Re: starting with 2.7
From: Daniel Gryniewicz <dang@fprintf.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Lang <dlang@digitalinsight.com>,
       Arjan van de Ven <arjan@infradead.org>, Rik van Riel <riel@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050106193510.GL3096@stusta.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <20050102203615.GL29332@holomorphy.com>
	 <20050102212427.GG2818@pclin040.win.tue.nl>
	 <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
	 <20050103153438.GF2980@stusta.de>
	 <1104767943.4192.17.camel@laptopd505.fenrus.org>
	 <20050104174712.GI3097@stusta.de>
	 <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com>
	 <20050106193510.GL3096@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Jan 2005 18:33:45 -0500
Message-Id: <1105054425.17473.30.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 20:35 +0100, Adrian Bunk wrote:
> On Tue, Jan 04, 2005 at 12:18:26PM -0800, David Lang wrote:
> But the question is if you compile and test a kernel, is it every 
> unlikely or relatively common to observe new problems?

In my case, for -linus, never.  For -mm, relatively common.  This
indicates to me that the process is working.

(Every case I thought I'd hit of a regression was a result of some patch
on top of -linus, usually -ck or -mm.)

Daniel
