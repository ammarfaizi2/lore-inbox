Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTJHBtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 21:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTJHBtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 21:49:14 -0400
Received: from codepoet.org ([166.70.99.138]:49038 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S261309AbTJHBtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 21:49:00 -0400
Date: Tue, 7 Oct 2003 19:49:02 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com
Subject: Re: Megaraid does not work with 2.4.22
Message-ID: <20031008014902.GA21267@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Xose Vazquez Perez <xose@wanadoo.es>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com
References: <Pine.LNX.4.44.0310072151220.27859-100000@logos.cnet> <3F8363B0.60301@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8363B0.60301@wanadoo.es>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 08, 2003 at 03:09:04AM +0200, Xose Vazquez Perez wrote:
> Marcelo Tosatti wrote:
> 
> >>Here go some trivial fixes(add menu entry, list all compatibles
> >>boards in help and put tab instead spaces) for megaraid2.
> > 
> > 
> > Those are already in the merged megaraid2
> 
> This is a patch against 2.4.22-bk30, and it's
> necessary to be able to compile megaraid2 and to
> get help text from menuconfig.

Xose is correct.  His patch should indeed be applied to the
latest bk tree so the megaraid2 driver can actually be compiled
into 2.4.x.  

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
