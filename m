Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbSJNAV1>; Sun, 13 Oct 2002 20:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbSJNAV0>; Sun, 13 Oct 2002 20:21:26 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18180 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261767AbSJNAV0>;
	Sun, 13 Oct 2002 20:21:26 -0400
Date: Sun, 13 Oct 2002 17:27:42 -0700
From: Greg KH <greg@kroah.com>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.42-ac1: modprobe uhci-hcd: sleeping function called from illegal context
Message-ID: <20021014002742.GA1062@kroah.com>
References: <20021013122139.GA377@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013122139.GA377@steel>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 02:21:39PM +0200, Alex Riesen wrote:
> Just tried "modprobe uhci-hcd". Nothing evil observed besides that.

Fixed in the set of patches I just sent to Linus.

thanks,

greg k-h
