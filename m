Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750825AbWFEVHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWFEVHR (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWFEVHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:07:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19610 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750825AbWFEVHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:07:15 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, mbligh@google.com, apw@shadowen.org,
        mbligh@mbligh.org, linux-kernel@vger.kernel.org, ak@suse.de,
        hugh@veritas.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20060605135812.30138205.akpm@osdl.org>
References: <447DEF49.9070401@google.com>
	 <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org>
	 <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org>
	 <447F1702.3090405@shadowen.org> <44842C01.2050604@shadowen.org>
	 <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
	 <44848DD2.7010506@shadowen.org>
	 <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
	 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
	 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
	 <20060605135812.30138205.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 23:07:02 +0200
Message-Id: <1149541622.3111.132.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 13:58 -0700, Andrew Morton wrote:
> I wonder what LTP was corrupting before it started to corrupt page
> migration data?

how about mutex debug data structures? ;)

