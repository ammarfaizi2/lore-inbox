Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264859AbVBDX0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264859AbVBDX0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbVBDX0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:26:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:36231 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264859AbVBDX01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:26:27 -0500
Date: Fri, 4 Feb 2005 15:25:25 -0800
From: Greg KH <greg@kroah.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: LM Sensors <sensors@Stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] ST M41T00 I2C RTC chip driver
Message-ID: <20050204232525.GA28571@kroah.com>
References: <41FE7368.1000307@mvista.com> <20050131210319.44a69d49.khali@linux-fr.org> <41FFE9EE.3000504@mvista.com> <420401EB.5080700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420401EB.5080700@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 04:14:51PM -0700, Mark A. Greer wrote:
> From http://archives.andrew.net.au/lm-sensors/msg29319.html:
> 
> Mark A. Greer wrote:
> 
> ><snip>
> >
> >Here is a replacement patch that should address Jean Delvare and Dick 
> >Johnson's issues.  Please let me know if there are any more issues.
> >
> >Thanks,
> >
> >Mark
> >
> >Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> >-- 
> 
> 
> I haven't heard of any more problems so can I get this patch applied?

Can you resend it with a proper Changelog description in the top of the
email and the signed-off-by line?  thanks,

greg k-h
