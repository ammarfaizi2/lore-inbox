Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTJCWMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTJCWMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:12:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:21218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261321AbTJCWML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:12:11 -0400
Date: Fri, 3 Oct 2003 15:11:31 -0700
From: Greg KH <greg@kroah.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] [TRIVIAL 5/12] 2.6.0-test6-bk remove reference to modules.txt in drivers/usb/input/Kconfig
Message-ID: <20031003221131.GA3784@kroah.com>
References: <1065025124.1995.2406.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065025124.1995.2406.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 10:18:44AM -0600, Steven Cole wrote:
> This patch removes the reference to Documentation/modules.txt,
> which has been removed.  The patch was made against the current
> 2.6-bk tree.

Applied, thanks.

greg k-h
