Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVCWUcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVCWUcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVCWU33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:29:29 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:60387 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262909AbVCWU2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:28:38 -0500
Date: Wed, 23 Mar 2005 15:28:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Adrian Bunk <bunk@stusta.de>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/eql.c: kill dead code
Message-ID: <20050323202823.GA11453@havoc.gtf.org>
References: <20050322215354.GM1948@stusta.de> <20050323122212.776975d4.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323122212.776975d4.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 12:22:12PM -0800, David S. Miller wrote:
> On Tue, 22 Mar 2005 22:53:54 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch removes some obviously dead code found by the Coverity 
> > checker.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Applied, thanks Adrian.

Note that I apply drivers/net/* stuff too, including this one...  :)

http://marc.theaimsgroup.com/?l=linux-kernel&m=111154928104675&w=2

	Jeff



