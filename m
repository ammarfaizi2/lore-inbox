Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262949AbSJBDWu>; Tue, 1 Oct 2002 23:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262950AbSJBDWu>; Tue, 1 Oct 2002 23:22:50 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:53512 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262949AbSJBDWt>;
	Tue, 1 Oct 2002 23:22:49 -0400
Date: Tue, 1 Oct 2002 20:25:49 -0700
From: Greg KH <greg@kroah.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
Subject: Re: 2.5.39 + evms 1.2.0 burn test
Message-ID: <20021002032548.GB11871@kroah.com>
References: <20021002030422.GA2127@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002030422.GA2127@merlin.emma.line.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 05:04:22AM +0200, Matthias Andree wrote:
> 
> 5. usb: usbkbd (module) cannot be loaded, missing symbol:
>    usb_kbd_free_buffers.

Vojtech, I've seen this for a while, but forgot to mention it.  Any fix?

thanks,

greg k-h
