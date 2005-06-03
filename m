Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVFCVUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVFCVUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVFCVUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 17:20:19 -0400
Received: from animx.eu.org ([216.98.75.249]:44981 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261401AbVFCVUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 17:20:15 -0400
Date: Fri, 3 Jun 2005 17:16:25 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050603211625.GA17637@animx.eu.org>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org> <20050526122315.GA3880@nd47.coderock.org> <20050526122724.GA3396@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526122724.GA3396@ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, May 26, 2005 at 02:23:15PM +0200, Domen Puncer wrote:
> 
> > Still true for 2.6.12-rc5. Should probably be fixed before final.
> 
> Caused by a bug in the atkbd-scroll feature. The attached patch
> fixes it.

Yes it does, thanks.  What's the "scroll" feature?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
