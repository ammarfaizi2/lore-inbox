Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270489AbUJTXyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270489AbUJTXyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270532AbUJTXxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:53:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:8872 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270538AbUJTXxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:53:11 -0400
Date: Wed, 20 Oct 2004 16:49:52 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: remove (unneeded proto) that causes a warning w/o CONFIG_PM
Message-ID: <20041020234952.GC16559@kroah.com>
References: <20041020023803.GF8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020023803.GF8597@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 07:38:03PM -0700, Chris Wedgwood wrote:
> remove (unneeded proto) that causes a warning w/o CONFIG_PM
> 
> Signed-off-by: cw@f00f.org

Applied, thanks.

greg k-h
