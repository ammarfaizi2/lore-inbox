Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285330AbRLGAIJ>; Thu, 6 Dec 2001 19:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285329AbRLGAIA>; Thu, 6 Dec 2001 19:08:00 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:4103 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285328AbRLGAHz>;
	Thu, 6 Dec 2001 19:07:55 -0500
Date: Thu, 6 Dec 2001 16:06:57 -0800
From: Greg KH <greg@kroah.com>
To: Will Dyson <will_dyson@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: link error in usbdrv.o (2.4.17-pre5)
Message-ID: <20011206160656.Q2710@kroah.com>
In-Reply-To: <3C0FFACF.4060806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C0FFACF.4060806@pobox.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 08 Nov 2001 18:50:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 06:10:07PM -0500, Will Dyson wrote:
> When compiling 2.4.17-pre5 with the usb compiled in, the final link 
> produces the following error:

Enable CONFIG_HOTPLUG to fix this for now.

thanks,

greg k-h
