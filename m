Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263168AbTC1WGG>; Fri, 28 Mar 2003 17:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263170AbTC1WGG>; Fri, 28 Mar 2003 17:06:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:12 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263168AbTC1WF4>;
	Fri, 28 Mar 2003 17:05:56 -0500
Date: Fri, 28 Mar 2003 14:15:57 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: handle failure of usb_set_interface.
Message-ID: <20030328221557.GB649@kroah.com>
References: <200303261804.59133.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303261804.59133.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 06:04:59PM +0100, Duncan Sands wrote:
>  speedtch.c |   26 ++++++++++++++++++--------
>  1 files changed, 18 insertions(+), 8 deletions(-)

Applied, thanks.

greg k-h

