Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312980AbSDORAU>; Mon, 15 Apr 2002 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312982AbSDORAT>; Mon, 15 Apr 2002 13:00:19 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:41484 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312980AbSDORAS>;
	Mon, 15 Apr 2002 13:00:18 -0400
Date: Mon, 15 Apr 2002 08:59:48 -0700
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS: USB disconnect
Message-ID: <20020415155947.GB21707@kroah.com>
In-Reply-To: <3CBA8506.AE090B97@delusion.de> <20020415152310.GH21356@kroah.com> <3CBAFFC2.2FB7ECFE@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 18 Mar 2002 13:44:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 06:28:50PM +0200, Udo A. Steinberg wrote:
> I'm using the "normal" UHCI driver, not the JE one. I believe the
> oops is related to USB HID device support, which I didn't use in 2.5.7
> but enabled for 2.5.8, after which the oops happened.

Could you test out 2.5.7 and the HID device support in that version to
see if this is a new problem or not?

thanks,

greg k-h
