Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbUJ3V3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUJ3V3w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUJ3V3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:29:51 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:64659 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261333AbUJ3V23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:28:29 -0400
Date: Sun, 31 Oct 2004 01:29:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Brian Gerst <bgerst@quark.didntduck.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove last reference to LDFLAGS_BLOB
Message-ID: <20041030232917.GE9592@mars.ravnborg.org>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Brian Gerst <bgerst@quark.didntduck.org>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <4175C6E2.1080201@quark.didntduck.org> <20041020175927.GE14780@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020175927.GE14780@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 03:59:27PM -0200, Marcelo Tosatti wrote:
> 
> No, do not remove that initramfs_data.S section!

It's in a comment section??

Anyway for now I only removed the assignment in m32r Makefile.

	Sam
