Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289970AbSAWXGL>; Wed, 23 Jan 2002 18:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSAWXGB>; Wed, 23 Jan 2002 18:06:01 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:6149 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289970AbSAWXFq>;
	Wed, 23 Jan 2002 18:05:46 -0500
Date: Wed, 23 Jan 2002 15:00:47 -0800
From: Greg KH <greg@kroah.com>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: depmod problem for 2.5.2-dj4
Message-ID: <20020123230047.GF15259@kroah.com>
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net> <20020123045405.GA12060@kroah.com> <20020123094414.D5170@suse.cz> <20020123212435.GB15259@kroah.com> <20020123222251.GE15259@kroah.com> <20020123234714.A7536@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020123234714.A7536@suse.cz>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 26 Dec 2001 18:49:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 11:47:14PM +0100, Vojtech Pavlik wrote:
> 
> Yes, this is perfect. *shiver* I can't believe I made the code so leaky.
> Sorry for that, it's a copy-paste problem.
> Thanks for fixing it.

No problem, I'll send it out in my next round of patches.

greg k-h
