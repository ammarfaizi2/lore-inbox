Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270844AbTGNV3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTGNV3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:29:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:61660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270844AbTGNV3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:29:22 -0400
Date: Mon, 14 Jul 2003 14:44:11 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Babut <thomas.babut@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Many Unresolved Symbols
Message-ID: <20030714214411.GA5855@kroah.com>
References: <000001c34a46$a131afa0$6300a8c0@tom3k>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c34a46$a131afa0$6300a8c0@tom3k>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 10:29:29PM +0200, Thomas Babut wrote:
> Hi,
> 
> I am getting a lot of unresolved symbols after doing a 'make
> modules_install'.

Do you have module-init-tools installed?

greg k-h
