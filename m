Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbSKQXec>; Sun, 17 Nov 2002 18:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbSKQXec>; Sun, 17 Nov 2002 18:34:32 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:58892 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267613AbSKQXeb>;
	Sun, 17 Nov 2002 18:34:31 -0500
Date: Sun, 17 Nov 2002 15:35:21 -0800
From: Greg KH <greg@kroah.com>
To: Gustavo Puche =?iso-8859-1?Q?Rodr=EDguez?= 
	<GeenHavok@netscape.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with USB]
Message-ID: <20021117233521.GA7373@kroah.com>
References: <3DD827C2.1020601@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DD827C2.1020601@netscape.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 12:35:30AM +0100, Gustavo Puche Rodríguez wrote:
> 
> 
>    I have a 2.4.18 kernel and a motherboar EliteGroup K76SA, in the 
> boot messages apear a failure with the USB. This failure can be seen below:

Please see the FAQ at http://www.linux-usb.org/ for more info on this
problem (in short, it's a interrupt routing problem, not a USB one.)

thanks,

greg k-h
