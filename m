Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbULCXax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbULCXax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 18:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbULCXax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 18:30:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43143 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262502AbULCXar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 18:30:47 -0500
Date: Fri, 3 Dec 2004 15:26:50 -0800
From: Greg KH <greg@kroah.com>
To: peter@bartosch.net, linux-kernel@vger.kernel.org
Subject: Re: create_proc_entry within probe function (USB)
Message-ID: <20041203232650.GA24106@kroah.com>
References: <20041203080939.GA23984@bartosch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203080939.GA23984@bartosch.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 09:09:39AM +0100, Peter Bartosch wrote:
> Hello all,
> 
> 
> I'm developing a USB drive ant try to create a proc-entry within my
> probe-function. Neither create_proc_read_entry nor create_proc_entry do
> work completely:
> 
> If i disconnect/connect the USB-Hardware the proc-entries will be
> created. But: if i only reload the module the probe-function is
> called but the proc-entries won't be created!?

Do you have a pointer to your code anywhere?

thanks,

greg k-h
