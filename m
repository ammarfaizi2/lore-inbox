Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbTCYBSr>; Mon, 24 Mar 2003 20:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbTCYBSr>; Mon, 24 Mar 2003 20:18:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5136 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261313AbTCYBSq>;
	Mon, 24 Mar 2003 20:18:46 -0500
Date: Mon, 24 Mar 2003 17:29:23 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
Message-ID: <20030325012923.GA10879@kroah.com>
References: <10482950873871@kroah.com> <10482950921680@kroah.com> <20030325093550.GD1083@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325093550.GD1083@zaurus.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:35:50AM +0100, Pavel Machek wrote:
> Hi!
> 
> > +	.name		= "ADM1021-MAX1617",
> 
> Why dash here
> 
> > +	.name		= "LM75 sensor",
> 
> And space here? Also you should have 
> either 2x "sensor" or none at all. 

What do you mwan "2x"?  I just shortened that name up to fit within the
16 characters that we are allowed for driver names.  If you can come up
with some better ones, please let me know.

thanks,

greg k-h
