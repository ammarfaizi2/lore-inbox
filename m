Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269685AbUJGEZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbUJGEZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269687AbUJGEZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:25:34 -0400
Received: from linux.us.dell.com ([143.166.224.162]:35442 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S269685AbUJGEZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:25:29 -0400
Date: Wed, 6 Oct 2004 23:25:19 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alan@redhat.com, david.balazic@hermes.si
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
Message-ID: <20041007042519.GB7325@lists.us.dell.com>
References: <20041004214803.GC2989@lists.us.dell.com> <4164BF82.2040608@pobox.com> <20041006211605.17c1cb41.akpm@osdl.org> <20041007042026.GA18890@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007042026.GA18890@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 12:20:26AM -0400, Jeff Garzik wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > >  arch/i386/boot/edd.S:17: macro names must be identifiers
> 
> Maybe I was being foolish by applying the patch to mainline ;-)

I tested it on x86 mainline.  My x86_64 boxes are in disrepair due to
other work, but I'll build it there tomorrow myself...

-Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
