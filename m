Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270992AbTGPRSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTGPRS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:18:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:64189 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270992AbTGPRRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:17:53 -0400
Date: Wed, 16 Jul 2003 10:27:16 -0700
From: Greg KH <greg@kroah.com>
To: Georgi Chorbadzhiyski <gf@unixsol.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1-mm1 success, tiny mouse and framebuffer problems
Message-ID: <20030716172716.GA8030@kroah.com>
References: <3F156566.4040206@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F156566.4040206@unixsol.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 05:47:02PM +0300, Georgi Chorbadzhiyski wrote:
> 
> P.S. Every file in sysfs is 4096 bytes, is this normal?

Yes.

And they _all_ aren't 4096 bytes, there are a few that report other
sizes...

thanks,

greg k-h
