Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSIDVl1>; Wed, 4 Sep 2002 17:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSIDVl1>; Wed, 4 Sep 2002 17:41:27 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:20239 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315634AbSIDVlZ>;
	Wed, 4 Sep 2002 17:41:25 -0400
Date: Wed, 4 Sep 2002 14:44:02 -0700
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Message-ID: <20020904214402.GA8368@kroah.com>
References: <UTC200208312329.g7VNTwF11470.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200208312329.g7VNTwF11470.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 01:29:58AM +0200, Andries.Brouwer@cwi.nl wrote:
> 
> Without the patch the kernel crashes, or insmod usb-storage hangs.
> With the patch the CF part of the device works perfectly.

Matt, is it ok with you for me to add this patch to the tree?

thanks,

greg k-h
