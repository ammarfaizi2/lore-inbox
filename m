Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbTB1VbC>; Fri, 28 Feb 2003 16:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268141AbTB1VbC>; Fri, 28 Feb 2003 16:31:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57865 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268140AbTB1VbB>;
	Fri, 28 Feb 2003 16:31:01 -0500
Date: Fri, 28 Feb 2003 13:32:43 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: be firm when disconnected
Message-ID: <20030228213243.GE29266@kroah.com>
References: <200302281015.37848.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302281015.37848.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 10:15:37AM +0100, Duncan Sands wrote:
> Just say -ENODEV

Applied, thanks.

greg k-h
