Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVBAH5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVBAH5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVBAH4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:56:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:30883 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261836AbVBAHz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:55:57 -0500
Date: Mon, 31 Jan 2005 23:53:56 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH  block-2.6] aoe: fail IO on disk errors
Message-ID: <20050201075356.GD21608@kroah.com>
References: <87d5vt4k7k.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5vt4k7k.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 10:11:43AM -0500, Ed L Cashin wrote:
> This patch makes disk errors fail the IO instead of getting logged and
> ignored.
> 
> 
> Fail IO on disk errors
> Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

Applied, thanks.

greg k-h

