Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269458AbUINWZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269458AbUINWZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269226AbUINWZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:25:01 -0400
Received: from vapor.arctrix.com ([66.220.1.99]:29453 "HELO vapor.arctrix.com")
	by vger.kernel.org with SMTP id S269623AbUINWVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:21:55 -0400
Date: Tue, 14 Sep 2004 18:21:54 -0400
From: Neil Schemenauer <nas@arctrix.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG: debugging patch
Message-ID: <20040914222154.GA18434@mems-exchange.org>
References: <20040914211301.GA18197@mems-exchange.org> <20040914200603.GL30422@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914200603.GL30422@logos.cnet>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 05:06:03PM -0300, Marcelo Tosatti wrote:
> And your trace doesnt seem to look similar to his (different location inside
> prune_dcache from what I remember).
> 
> Anyway, how hard is for you to reproduce this? 

It's only happened once so far.  I'll upgrade to 2.6.8.1 and apply
your BUG patch on top.  If it happens again then maybe we will get
more info.

  Neil
