Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWIZJ27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWIZJ27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWIZJ27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:28:59 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:32640 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750926AbWIZJ26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:28:58 -0400
Date: Tue, 26 Sep 2006 11:28:41 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [PATCH 6/8] UML - Add checkstack support
Message-ID: <20060926092841.GA14085@wohnheim.fh-wedel.de>
References: <200609251834.k8PIYftQ005046@ccure.user-mode-linux.org> <20060925185852.GR6412@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060925185852.GR6412@waste.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 September 2006 13:58:52 -0500, Matt Mackall wrote:
> On Mon, Sep 25, 2006 at 02:34:41PM -0400, Jeff Dike wrote:
> > Make checkstack work for UML.  We need to pass the underlying architecture
> > name, rather than "um" to checkstack.pl.
> > 
> > Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Acked-by: Matt Mackall <mpm@selenic.com>
Acked-by: Joern Engel <joern@wohnheim.fh-wedel.de>

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown
