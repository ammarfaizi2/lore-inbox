Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVGDK7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVGDK7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGDK4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:56:40 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:29463 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261616AbVGDKyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:54:40 -0400
Date: Mon, 4 Jul 2005 12:57:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig changes: s/menu/menuconfig/
Message-ID: <20050704105722.GA21437@mars.ravnborg.org>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 11:06:01PM +0200, Bodo Eggert wrote:
> Part 1: The easy stuff.
> 
> In many config submenus, the first menu option will enable the rest 
> of the menu options. For these menus, It's appropriate to use the more 
> convenient "menuconfig" keyword.

Please do not touch net/Kconfig and friends. I am preparing an
update of this part so it will conflict.

	Sam
