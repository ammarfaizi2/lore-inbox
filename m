Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVBAI4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVBAI4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVBAIwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:52:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:35513 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261870AbVBAIwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:52:00 -0500
Date: Tue, 1 Feb 2005 00:18:01 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: phil@netroedge.com, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i2c-core.c: make some code static
Message-ID: <20050201081800.GA21968@kroah.com>
References: <20050131185955.GA18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131185955.GA18316@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 07:59:55PM +0100, Adrian Bunk wrote:
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h
