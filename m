Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269109AbUIBVB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269109AbUIBVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269082AbUIBUkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:40:17 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:24404 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269021AbUIBUia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:38:30 -0400
Date: Thu, 2 Sep 2004 22:40:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Oliver Antwerpen <olli@giesskaennchen.de>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Build error (objdump fails)
Message-ID: <20040902204055.GA18159@mars.ravnborg.org>
Mail-Followup-To: Oliver Antwerpen <olli@giesskaennchen.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41377705.9060305@giesskaennchen.de> <20040902201100.GA15298@mars.ravnborg.org> <4137815F.6040803@giesskaennchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4137815F.6040803@giesskaennchen.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 10:23:59PM +0200, Oliver Antwerpen wrote:
 
> 
> I now tried compiling with gcc-3.4 (3.4.1 (Debian 3.4.1-4sarge1)), that 
> works fine.
> 
> I am just compiling 2.6.8 with gcc-3.4. This fails at:
> mm/fremap.o: file not recognized: File truncated
> 
> Any ideas?
Nope - need more info to get an idea.

What filesystem do you use?
NFS, ext2, ???

What kernel are you running when compiling?

Any other parts of the system that shows abnormal behaviour?

	Sam
