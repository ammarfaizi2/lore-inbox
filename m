Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288005AbSAMHhU>; Sun, 13 Jan 2002 02:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288006AbSAMHhI>; Sun, 13 Jan 2002 02:37:08 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:19721 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288005AbSAMHgu>;
	Sun, 13 Jan 2002 02:36:50 -0500
Date: Sat, 12 Jan 2002 23:33:48 -0800
From: Greg KH <greg@kroah.com>
To: Cristiano Paris <c.paris@libero.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Mouse OOPS in 2.4.17
Message-ID: <20020113073348.GB7313@kroah.com>
In-Reply-To: <20020110160558.A7899@gandalf.rhpk.springfield.inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110160558.A7899@gandalf.rhpk.springfield.inwind.it>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 16 Dec 2001 04:45:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 04:05:58PM +0100, Cristiano Paris wrote:
> Here's the oops as a result from ksymoops :

Hm, is this repeatable?  Does it happen with the usb-uhci driver instead
of the uhci driver?

thanks,

greg k-h
