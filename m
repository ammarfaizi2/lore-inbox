Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUC1Qej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUC1Qej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:34:39 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:62217 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261980AbUC1Qef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:34:35 -0500
Date: Sun, 28 Mar 2004 20:34:03 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Willy TARREAU <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc1 => Alpha warnings
Message-ID: <20040328203403.B14868@jurassic.park.msu.ru>
References: <20040328042608.GA17969@logos.cnet> <20040328124022.GG24421@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040328124022.GG24421@pcw.home.local>; from willy@w.ods.org on Sun, Mar 28, 2004 at 02:40:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 02:40:22PM +0200, Willy TARREAU wrote:
> 2.4.26-rc1 compiled correctly on alpha, but I got amongst usual
> warnings a strange one (with gcc-3.2.3) :
> 
> math.c: In function `alpha_fp_emul':
> math.c:204: warning: right shift count is negative
> math.c:204: warning: left shift count >= width of type

These are "usual" too and absolutely harmless.

Ivan.
