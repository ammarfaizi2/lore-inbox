Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264616AbUD2O1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264616AbUD2O1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264618AbUD2O1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:27:46 -0400
Received: from levante.wiggy.net ([195.85.225.139]:35507 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S264616AbUD2O1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:27:43 -0400
Date: Thu, 29 Apr 2004 16:27:42 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429142742.GA21409@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org> <20040429022944.GA24000@buici.com> <20040428193541.1e2cf489.akpm@osdl.org> <20040429031059.GA26060@buici.com> <20040429080219.GF4437@wiggy.net> <20040429142528.GH18474@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429142528.GH18474@logos.cnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Marcelo Tosatti wrote:
> Which kernel is that? 

That machine is running 2.6.4 at the moment.

> They are getting killed because there is no more swap available.
> Otherwise its a bug.

It actually killed a bunch of processes a minute ago and right now has
120mb of swap free and 104mb used for cache. 

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

