Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262309AbSI1Sw1>; Sat, 28 Sep 2002 14:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSI1Sw1>; Sat, 28 Sep 2002 14:52:27 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:30224 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262309AbSI1Sw1>;
	Sat, 28 Sep 2002 14:52:27 -0400
Date: Sat, 28 Sep 2002 11:55:54 -0700
From: Greg KH <greg@kroah.com>
To: Nick Sanders <sandersn@btinternet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic 2.5.39 when starting hotplug
Message-ID: <20020928185554.GA17684@kroah.com>
References: <200209281324.47486.sandersn@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209281324.47486.sandersn@btinternet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 01:24:47PM +0100, Nick Sanders wrote:
> Hi,
> 
> I get a kernel panic when starting the hotplug daemon when running 2.5.39, the 
> config and boot log are attached.

What hotplug daemon?  What is that?  Do you mean a call to
/sbin/hotplug?

thanks,

greg k-h
