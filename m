Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSJaFgm>; Thu, 31 Oct 2002 00:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSJaFgm>; Thu, 31 Oct 2002 00:36:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:16913 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265085AbSJaFgm>;
	Thu, 31 Oct 2002 00:36:42 -0500
Date: Wed, 30 Oct 2002 21:40:16 -0800
From: Greg KH <greg@kroah.com>
To: David T Hollis <dhollis@davehollis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.45 drivers/net/irda/irda-usb.c Compile Fix
Message-ID: <20021031054016.GC5602@kroah.com>
References: <3DC0A143.2000304@davehollis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC0A143.2000304@davehollis.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 10:19:31PM -0500, David T Hollis wrote:
> Fixes an apparent typo in irda-usb.c that prevented it from compiling.

Oops, sorry about that, I didn't have irda debugging enabled when
building that file so I missed that one.  I'll add it to my tree and
send it off later.

thanks,

greg k-h
