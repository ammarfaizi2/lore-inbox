Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281797AbRLQR7H>; Mon, 17 Dec 2001 12:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRLQR65>; Mon, 17 Dec 2001 12:58:57 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:28690 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281739AbRLQR6q>;
	Mon, 17 Dec 2001 12:58:46 -0500
Date: Mon, 17 Dec 2001 09:55:47 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: USB [Toshiba PCX1100U CableModem] panic
Message-ID: <20011217095547.E31818@kroah.com>
In-Reply-To: <20011217114322.D16465@ksu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011217114322.D16465@ksu.edu>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 19 Nov 2001 14:37:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 11:43:22AM -0600, Joseph Pingenot wrote:
> [Sorry for the resend, but I didn't get any responses, nor a copy
> [ back (I usually do), nor did it appear in the archives.
> [ Did Majordomo burp?
> [As a postscript, I haven't found anything out yet.]
> 
> 
> I get the following oops if I try and run pump on eth1, the cable
>   modem:

Can you run that oops through ksymoops?

thanks,

greg k-h
