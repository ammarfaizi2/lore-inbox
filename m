Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTEZWhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTEZWhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:37:16 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:32016 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262358AbTEZWgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:36:38 -0400
Date: Mon, 26 May 2003 23:49:49 +0100
From: John Levon <levon@movementarian.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk19 "make" messages much less informative
Message-ID: <20030526224949.GA27375@compsoc.man.ac.uk>
References: <200305262223.h4QMN5D12796@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305262223.h4QMN5D12796@adam.yggdrasil.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19KQms-0009UU-1r*SGw5XCrpbbw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 03:23:05PM -0700, Adam J. Richter wrote:

> 	2.5.69-bk19 dumbs down the messages from make into a format

You can use make V=1 (I hope) to get the proper behaviour back

> 	This is much less informative than seeing the actual CC commands.

I completely agree. A step backwards :( V=0 is certainly useful but it
shouldn't be the default. You can't force people to pay attention to
warnings, only encourage them...

john
