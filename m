Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUH1JVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUH1JVn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUH1JVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:21:43 -0400
Received: from holomorphy.com ([207.189.100.168]:26021 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266867AbUH1JVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:21:03 -0400
Date: Sat, 28 Aug 2004 02:20:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
Message-ID: <20040828092052.GI5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com> <20040828101849.A7592@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828101849.A7592@infradead.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:18:49AM +0100, Christoph Hellwig wrote:
> Why __wkae_up_bit, not wake_up_bit?

A wake_up_bit() meant to be used more generally is added later in the
series.


-- wli
