Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVBAHzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVBAHzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVBAHzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:55:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:23971 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261804AbVBAHzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:55:48 -0500
Date: Mon, 31 Jan 2005 23:54:06 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH block-2.6] aoe status.sh: handle sysfs not in /etc/mtab
Message-ID: <20050201075406.GE21608@kroah.com>
References: <878y6fzyyd.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878y6fzyyd.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 04:02:02PM -0500, Ed L Cashin wrote:
> Suse 9.1 Pro doesn't put /sys in /etc/mtab.  This patch makes the
> example aoe status.sh script work when sysfs is mounted but `mount`
> doesn't mention sysfs.
> 
> 
> aoe status.sh: handle sysfs not in /etc/mtab
> Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

Applied, thanks.

greg k-h

