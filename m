Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbSKQAkC>; Sat, 16 Nov 2002 19:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbSKQAkB>; Sat, 16 Nov 2002 19:40:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:55050 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267417AbSKQAkB>;
	Sat, 16 Nov 2002 19:40:01 -0500
Date: Sat, 16 Nov 2002 16:41:00 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dead & Dying interfaces
Message-ID: <20021117004059.GC28824@kroah.com>
References: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 06:47:25PM +0000, Matthew Wilcox wrote:
> 
> pcibios_*
>  -> Documentation/pci.txt

I still have patches that remove all of the instances of this.  I think
it's already in the -ac kernel.  I'll forward port it next week and send
it to Linus.

thanks,

greg k-h
