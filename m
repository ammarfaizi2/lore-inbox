Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSJAUKl>; Tue, 1 Oct 2002 16:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262279AbSJAUKl>; Tue, 1 Oct 2002 16:10:41 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:63751 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262266AbSJAUKk>;
	Tue, 1 Oct 2002 16:10:40 -0400
Date: Tue, 1 Oct 2002 13:13:43 -0700
From: Greg KH <greg@kroah.com>
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] EVMS Release 1.2.0
Message-ID: <20021001201343.GB9551@kroah.com>
References: <0209301701470A.15956@boiler> <20021001102043.GD20878@suse.de> <02100108181900.20800@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02100108181900.20800@boiler>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 08:18:19AM -0500, Kevin Corry wrote:
> 
> If you have any additional comments, please let us know.

There are still a large number of improper variable names, and quite a
few typedefs throughout the kernel patch.  I thought these were going to
be fixed?

Also, is there any documentation on why the md code was reimplemented
within evms, instead of using the existing kernel code?

thanks,

greg k-h
