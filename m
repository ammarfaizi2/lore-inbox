Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWDYDuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWDYDuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 23:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWDYDuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 23:50:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:9626 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751359AbWDYDuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 23:50:51 -0400
Date: Mon, 24 Apr 2006 20:49:30 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 0/4] kref debugging
Message-ID: <20060425034930.GA18085@kroah.com>
References: <20060424083333.217677000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424083333.217677000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 04:33:33PM +0800, Akinobu Mita wrote:
> This patch series introduces the DEBUG_KREF config option.

Any reason you didn't CC: the kref author and maintainer?  :(

thanks,

greg k-h
