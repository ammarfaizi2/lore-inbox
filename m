Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVBAIu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVBAIu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVBAIu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:50:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:5561 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261538AbVBAIuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:50:54 -0500
Date: Tue, 1 Feb 2005 00:38:00 -0800
From: Greg KH <greg@kroah.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] change sematics of read flag
Message-ID: <20050201083800.GB22162@kroah.com>
References: <Pine.CYG.4.58.0501211452420.3364@mawilli1-desk2.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0501211452420.3364@mawilli1-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 02:55:09PM -0800, Mitch Williams wrote:
> This patch reverses the semantics of the read fill flag, getting rid of an
> extra assignment at allocation time.
> 
> Generated from 2.6.11-rc1.
> 
> Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>

Applied, thanks.

greg k-h
