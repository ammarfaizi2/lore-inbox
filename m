Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVBGWtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVBGWtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBGWsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:48:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:712 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261291AbVBGWri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:47:38 -0500
Date: Mon, 7 Feb 2005 14:47:34 -0800
From: Chris Wright <chrisw@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Chris Wright <chrisw@osdl.org>,
       =?iso-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Filesystem linking protections
Message-ID: <20050207144734.C469@build.pdx.osdl.net>
References: <1107802626.3754.224.camel@localhost.localdomain> <20050207111235.Y24171@build.pdx.osdl.net> <4207C4C7.8080704@comcast.net> <20050207120516.A24171@build.pdx.osdl.net> <4207EBD4.9090104@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4207EBD4.9090104@comcast.net>; from nigelenki@comcast.net on Mon, Feb 07, 2005 at 05:29:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Richard Moser (nigelenki@comcast.net) wrote:
> Yes, mkdtemp() and mkstemp().
> 
> Of course we can't always rely on programmers to get it right, so the
> idea here is to make sure we ask broken code to behave nicely, and stab
> it in the face if it doesn't.  Please try to examine this in that scope.

It's fine for hardened distro.  But still inappropriate for mainline.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
