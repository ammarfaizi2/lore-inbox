Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUEHAWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUEHAWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUEHAWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:22:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:46723 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263885AbUEHAVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:21:45 -0400
Date: Fri, 7 May 2004 15:25:49 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC 1/2] kobject_set_name - error handling
Message-ID: <20040507222549.GB14660@kroah.com>
References: <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com> <200404300748.14151.dtor_core@ameritech.net> <20040504053908.GA2900@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040504053908.GA2900@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 11:09:08AM +0530, Maneesh Soni wrote:
> 
> Greg, Are the patches fit for inclusion? I need to know this as my sysfs backing
> store patches are taking back seats because of these changes, particulary the
> one in second patch :-(.

I'm awash in different patches from you.  Can you try sending me the
ones you think are good enough for inclusion right now?  We can work
from there.

thanks,

greg k-h
