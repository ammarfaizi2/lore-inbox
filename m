Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTFPS3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTFPS3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:29:12 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:21657 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264094AbTFPS3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:29:07 -0400
Date: Mon, 16 Jun 2003 11:42:02 -0700
From: Greg KH <greg@kroah.com>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
Message-ID: <20030616184202.GD25585@kroah.com>
References: <5.1.0.14.2.20030612120959.00aec370@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030612120959.00aec370@pop.t-online.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:22:33PM +0200, Margit Schubert-While wrote:
> OK Here's the patch which :
> 1) Fixes the race conditions
> 2) Correctly reports the temps :-)
> 3) Removes a bit of gunk in the defines which I forgot

Applied, thanks.

greg k-h
