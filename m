Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVBNFWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVBNFWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 00:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVBNFWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 00:22:48 -0500
Received: from almesberger.net ([63.105.73.238]:56326 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261339AbVBNFWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 00:22:46 -0500
Date: Mon, 14 Feb 2005 02:21:14 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Matt Mackall <mpm@selenic.com>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050214022114.A23461@almesberger.net>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211081422.GB2287@elte.hu>; from mingo@elte.hu on Fri, Feb 11, 2005 at 09:14:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> the pro applications will always want to have a 100% guarantee (it
> really sucks to generate a nasty audio click during a live performance)

... and the "generic kernels" distributions use will follow just
as swiftly, as soon as the feature appears stable enough. It even
makes sense: no need to switch kernels if "pro audio" applications
(or whatever else may end up wanting this) are added to the mix,
and fewer configurations to test.

You can run, but you cannot hide :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
