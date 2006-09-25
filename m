Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWIYTAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWIYTAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 15:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIYTAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 15:00:36 -0400
Received: from waste.org ([66.93.16.53]:29075 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751491AbWIYTAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 15:00:35 -0400
Date: Mon, 25 Sep 2006 13:58:52 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Paolo Giarrusso <blaisorblade@yahoo.it>,
       Joern Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 6/8] UML - Add checkstack support
Message-ID: <20060925185852.GR6412@waste.org>
References: <200609251834.k8PIYftQ005046@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609251834.k8PIYftQ005046@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 02:34:41PM -0400, Jeff Dike wrote:
> Make checkstack work for UML.  We need to pass the underlying architecture
> name, rather than "um" to checkstack.pl.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
