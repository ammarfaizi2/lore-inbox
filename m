Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbTCWHAg>; Sun, 23 Mar 2003 02:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbTCWHAf>; Sun, 23 Mar 2003 02:00:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:49675 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262877AbTCWHAc>;
	Sun, 23 Mar 2003 02:00:32 -0500
Date: Sat, 22 Mar 2003 23:11:25 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.65-ac3
Message-ID: <20030323071124.GA23036@kroah.com>
References: <3E7CF48F.9070204@pobox.com> <200303230044.h2N0i9r32560@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303230044.h2N0i9r32560@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 07:44:09PM -0500, Alan Cox wrote:
> Fixing the pci api hotplug races

Is this just the pci device list issue (lack of locking), or something
else?

thanks,

greg k-h
