Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUHOI6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUHOI6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 04:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUHOI6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 04:58:39 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:53301 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266560AbUHOI6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 04:58:38 -0400
Date: Sun, 15 Aug 2004 11:01:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] scripts/kernel-doc and comma separated members.
Message-ID: <20040815090110.GA20781@mars.ravnborg.org>
Mail-Followup-To: Alexey Dobriyan <adobriyan@mail.ru>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <E1BF9ow-000FFX-00.adobriyan-mail-ru@f16.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BF9ow-000FFX-00.adobriyan-mail-ru@f16.mail.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 02:46:42PM +0400, "Alexey Dobriyan"  wrote:
> This patch teaches scripts/kernel-doc to print descriptions
> of comma separated variables correctly instead of ignoring
> them.
> 
> Tested on 'make pdfdocs' and 'scripts/kernel-doc -text test.c'.

Applied - thanks.

	Sam
