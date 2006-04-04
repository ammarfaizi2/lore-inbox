Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWDDVXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWDDVXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWDDVXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:23:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750891AbWDDVXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:23:50 -0400
Date: Tue, 4 Apr 2006 14:22:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: dtor_core@ameritech.net, rene.herman@keyaccess.nl,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: patch
 bus_add_device-losing-an-error-return-from-the-probe-method.patch added to
 gregkh-2.6 tree
Message-Id: <20060404142241.66bfdb70.akpm@osdl.org>
In-Reply-To: <20060404211505.GA7760@suse.de>
References: <44238489.8090402@keyaccess.nl>
	<1FQquz-2CO-00@press.kroah.org>
	<d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com>
	<20060404210048.GA5694@suse.de>
	<20060404211505.GA7760@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
> > So, I'm pretty sure that this is safe and should work just fine.  To be
>  > sure, let me go reboot my box with this change on it after I finish this
>  > email :)
> 
>  Yup, things still seem to work properly for me.  The patch will show up
>  in the next -mm for others to beat on...

It was in 2.6.16-mm2 and 2.6.17-rc1-mm1.
