Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUGBVCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUGBVCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUGBVCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:02:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:23172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264928AbUGBVC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:02:29 -0400
Date: Fri, 2 Jul 2004 13:58:07 -0700
From: Greg KH <greg@kroah.com>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: Greg KH <gregkh@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Pat Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Jess Botts <botts@us.ibm.com>, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [PATCH] [0/2] acpiphp extension for 2.6.7
Message-ID: <20040702205806.GF29580@kroah.com>
References: <1087934028.2068.57.camel@bluerat> <20040624214555.GA1800@us.ibm.com> <1088553033.25961.63.camel@bluerat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088553033.25961.63.camel@bluerat>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 04:50:33PM -0700, Vernon Mauery wrote:
> After much discussion, dissection, rewriting and reading (documentation
> of course), I finally think this patch is ready to be included in the
> kernel.  I have chosen to split it into 2 parts because really, that's
> what it is -- a patch to acpiphp that allows other modules to register
> attention LED callback functions and also a new module that does just
> that for the IBM ACPI systems.  These patches were made against the
> 2.6.7 kernel tree.

I'm going to hold off applying these till you address the issues raised
on the mailing list.

thanks,

greg k-h
