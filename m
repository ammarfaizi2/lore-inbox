Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275497AbTHNUmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275503AbTHNUmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:42:19 -0400
Received: from guug.org ([168.234.203.30]:16138 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S275497AbTHNUmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:42:18 -0400
Date: Thu, 14 Aug 2003 14:36:58 -0600
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBDEV updates.
Message-ID: <20030814203658.GE7862@guug.org>
References: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 08:54:21PM +0100, James Simmons wrote:
> 
> Hi folks!!
> 
>   Here is the latest fbdev BK drop. It is against 2.6.0-test3. Test it out 
> and tell me your results. I like to do a code drop soon. 

James:

what is the current state of PM in fb drivers?

does modedb is being used on 2.6 drivers?

Is there an API (or lib) to use framebuffers devices without
worring about differents visuals?, to quering, setting or
disabling EDID support? will these drivers export sysfs
entries instead of control via ioctl's?

thanks for your work on fb.

-solca

