Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVA3Pyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVA3Pyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVA3Pyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:54:40 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:53286 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261717AbVA3Pyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:54:39 -0500
Date: Sun, 30 Jan 2005 16:56:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kbuild 4/5] Include type information as module info where possible
Message-ID: <20050130155623.GA8408@mars.ravnborg.org>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <1106151255.8642.11.camel@winden.suse.de> <200501201254.46253.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501201254.46253.agruen@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 12:54:46PM +0100, Andreas Gruenbacher wrote:
> On Wednesday 19 January 2005 17:14, you wrote:
> > Hello,
> >
> > MODULE_PARM_TYPE needs to be moved to moduleparam.h: several files
> > include moduleparam.h but not module.h.
> 
> Ah, and __MODULE_INFO needs to be moved to moduleparam.h now as well:

Rusty got the original patch applied.
Can you please update this to latest kernel and resend including updated
changelog.

Thanks,
	Sam
