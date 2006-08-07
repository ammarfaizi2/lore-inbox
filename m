Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWHGVGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWHGVGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWHGVGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:06:45 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:3473 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932271AbWHGVGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:06:44 -0400
Date: Mon, 7 Aug 2006 23:06:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: arm + sh cross compile suite for amd64 (i386)?
Message-ID: <20060807210625.GB14327@mars.ravnborg.org>
References: <20060807192708.GA12937@mars.ravnborg.org> <20060807204241.GA11510@kroah.com> <20060807210209.GA14327@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807210209.GA14327@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 11:02:09PM +0200, Sam Ravnborg wrote:
 
> So for sh I would expect the following is a better fix:

Reminds me. Anyone has a pointer to arm+sh gcc + binutils cross-compile
suite that can run on my amd64 box?
My usual source: http://developer.osdl.org/dev/plm/cross_compile/
did have neither sh nor arm :-(

	Sam
