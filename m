Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUENTMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUENTMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUENTMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:12:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:58858 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262170AbUENTMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:12:08 -0400
Date: Fri, 14 May 2004 12:10:38 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC 2/2] sysfs_rename_dir-cleanup
Message-ID: <20040514191036.GC2620@kroah.com>
References: <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com> <200404300748.14151.dtor_core@ameritech.net> <20040504053908.GA2900@in.ibm.com> <20040507222549.GB14660@kroah.com> <20030509153523.A20357@in.ibm.com> <20030509153957.A20432@in.ibm.com> <20040511233350.GC27069@kroah.com> <20041007051623.GA14967@in.ibm.com> <20041007053845.GB14967@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007053845.GB14967@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 11:08:45AM +0530, Maneesh Soni wrote:
> 
> Bad me.. can't wait for compilation to over. There was one typo. Very sorry
> for the bad patch. Just make "new_dentrty" to "new_dentry" or use this correct 
> one.

Thanks, this one worked, I've applied it.

greg k-h
