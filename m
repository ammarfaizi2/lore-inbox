Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbUCGSks (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 13:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbUCGSks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 13:40:48 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:42854 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262299AbUCGSkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 13:40:47 -0500
Date: Sun, 7 Mar 2004 19:37:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: External kernel modules, second try
Message-ID: <20040307183715.GC2002@mars.ravnborg.org>
Mail-Followup-To: Sergey Vlasov <vsu@altlinux.ru>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
References: <1078620297.3156.139.camel@nb.suse.de> <20040307125348.GA2020@mars.ravnborg.org> <1078666334.3594.31.camel@nb.suse.de> <pan.2004.03.07.15.09.54.765466@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.03.07.15.09.54.765466@altlinux.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 06:09:55PM +0300, Sergey Vlasov wrote:
> 
> However, one little problem still remains: What if external modules from
> one package need to use symbols from modules which are also external, but
> in a different package?

We want to concentrate on getting the simple case right, then we can add
more functionality later.

	Sam
