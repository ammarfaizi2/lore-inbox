Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSILWmC>; Thu, 12 Sep 2002 18:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSILWmC>; Thu, 12 Sep 2002 18:42:02 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:59400 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317072AbSILWmB>;
	Thu, 12 Sep 2002 18:42:01 -0400
Date: Thu, 12 Sep 2002 15:43:24 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4-ac] trivial ohci fixes
Message-ID: <20020912224324.GB22099@kroah.com>
References: <Pine.LNX.4.44.0209101922480.1100-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209101922480.1100-100000@linux-box.realnet.co.sz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 07:26:17PM +0200, Zwane Mwaikambo wrote:
> Hi Greg, Alan,
> 	This is just a trivial patch for the following, and also a 
> buglet (clear_bit usb_register/derister race there?) fix

Applied to my tree, thanks.

greg k-h
