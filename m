Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbRE3QuM>; Wed, 30 May 2001 12:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbRE3QuC>; Wed, 30 May 2001 12:50:02 -0400
Received: from [65.0.121.190] ([65.0.121.190]:63749 "HELO kroah.com")
	by vger.kernel.org with SMTP id <S261616AbRE3Qtw>;
	Wed, 30 May 2001 12:49:52 -0400
Date: Wed, 30 May 2001 08:50:02 -0700
From: Greg KH <greg@kroah.com>
To: Philip Blundell <philb@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: empeg-car serial-over-USB driver
Message-ID: <20010530085002.B7544@kroah.com>
In-Reply-To: <E154rma-00009D-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E154rma-00009D-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Tue, May 29, 2001 at 11:16:08PM +0100
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 11:16:08PM +0100, Philip Blundell wrote:
> Has anybody used this successfully in a recent kernel?  With 2.4.5 it seems to 
> detect the device successfully:

Are you _sure_ you are using usb-uhci and not uhci? :)
Any oops message available from a serial console?

> empeg.c: v1.0.0 Greg Kroah-Hartman <greg@kroah.com>, Gary Brubaker <xavyer@ix.netcom.com>

Try emailing Gary, as he is current maintainer of the driver.

thanks,

greg k-h
