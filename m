Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269400AbUI3SkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbUI3SkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269411AbUI3SkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:40:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59624 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269409AbUI3Sir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:38:47 -0400
Date: Thu, 30 Sep 2004 14:38:27 -0400
From: Alan Cox <alan@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>, y@redhat.com
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: PATCH: Kconfig for EDD
Message-ID: <20040930183827.GA27775@devserv.devel.redhat.com>
References: <20040930175247.GA31128@devserv.devel.redhat.com> <415C522B.10502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415C522B.10502@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 02:36:27PM -0400, Jeff Garzik wrote:
> Alan Cox wrote:
> >EDD fails with ACARD scsi devices present (hang on the 16bit bios call at 
> >boot)
> 
> Please CC the maintainer of the code, Matt Domsch.

I sent him a report a couple of days ago

