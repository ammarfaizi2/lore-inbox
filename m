Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271259AbTGWTtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271265AbTGWTtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:49:21 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.131.35]:65239 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S271259AbTGWTtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:49:20 -0400
Date: Wed, 23 Jul 2003 16:04:26 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: directory inclusion in ext2/ext3
Message-ID: <20030723160426.A31006@newbox.localdomain>
References: <20030723193645.99E3C371@mendocino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030723193645.99E3C371@mendocino>; from softpro@gmx.net on Wed, Jul 23, 2003 at 09:36:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

softpro@gmx.net on Wed 23/07 21:36 +0200:
> i have been looking for the possibility to display the
> contents of several directories in another one, but have
> so far not found anything suitable.

This sounds like Al Viro's unionfs if I'm not mistaken.
