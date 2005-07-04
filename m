Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVGDMpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVGDMpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVGDMoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:44:07 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:13036 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261668AbVGDMho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:37:44 -0400
Date: Mon, 4 Jul 2005 14:37:22 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig changes: s/menu/menuconfig/
In-Reply-To: <20050704105722.GA21437@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0507041436520.11818@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <20050704105722.GA21437@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Sam Ravnborg wrote:
> On Thu, Jun 30, 2005 at 11:06:01PM +0200, Bodo Eggert wrote:
> > Part 1: The easy stuff.

> > In many config submenus, the first menu option will enable the rest 
> > of the menu options. For these menus, It's appropriate to use the more 
> > convenient "menuconfig" keyword.
> 
> Please do not touch net/Kconfig and friends. I am preparing an
> update of this part so it will conflict.

What about drivers/net/*?
-- 
The complexity of a weapon is inversely proportional to the IQ of the
weapon's operator.
