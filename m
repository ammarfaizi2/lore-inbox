Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269518AbTGJR5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269447AbTGJR5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:57:24 -0400
Received: from storm.he.net ([64.71.150.66]:48051 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S269518AbTGJR4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:56:51 -0400
Date: Thu, 10 Jul 2003 11:11:37 -0700
From: Greg KH <greg@kroah.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm3 oops when registering USB serial console
Message-ID: <20030710181136.GA12591@kroah.com>
References: <200307110106.32132.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307110106.32132.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 01:09:03AM +0800, Michael Frank wrote:
> Thanks to Randy Dunlap for fixing the USB console config.

No, please do not apply his patch.

> Sorry, this is like fighting dragons, cut off one head, get 2 more ;-)

Without his patch, does this still happen?  If so, can you send your
.config?

thanks,

greg k-h
