Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTFXXjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTFXXjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:39:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28621 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263295AbTFXXjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:39:45 -0400
Subject: Re: 2.5.73 compile results
From: John Cherry <cherry@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030624183156.GA11266@mars.ravnborg.org>
References: <1056475577.9839.110.camel@cherrypit.pdx.osdl.net>
	 <20030624173900.GV3710@fs.tum.de>
	 <1056478596.9839.118.camel@cherrypit.pdx.osdl.net>
	 <20030624183156.GA11266@mars.ravnborg.org>
Content-Type: text/plain
Organization: 
Message-Id: <1056498976.9839.201.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Jun 2003 16:56:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse output is a bit noisy right now.  I'll go ahead and post the
sparse output with the rest of the stats, but it is not for the faint of
heart.

On Tue, 2003-06-24 at 11:31, Sam Ravnborg wrote:
> On Tue, Jun 24, 2003 at 11:16:37AM -0700, John Cherry wrote:
> > Unfortunately, the build continues even when it runs into compile or
> > link errors.
> I just wnat to add here that the build continue because 'make -k' is
> used because the script counts all errors that occur - not just the first
> one is see.
> 
> John - any progress in sparse support - or too noisy?
> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

