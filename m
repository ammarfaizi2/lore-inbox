Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263966AbTDJAT4 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 20:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTDJAT4 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 20:19:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:8842 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263966AbTDJATz (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 20:19:55 -0400
Date: Wed, 9 Apr 2003 17:33:56 -0700
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add driver for powermac keywest i2c interface
Message-ID: <20030410003356.GA3751@kroah.com>
References: <16020.47275.52716.781180@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16020.47275.52716.781180@argo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 10:19:55AM +1000, Paul Mackerras wrote:
> Greg,
> 
> Here is a patch that adds an i2c bus driver for the i2c interface
> found in the "KeyWest" and later combo-I/O chips used in powermacs.
> The patch is against Linus' current BK tree.

Applied, thanks.

greg k-h
