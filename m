Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUEHAVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUEHAVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUEHAVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:21:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:35971 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263928AbUEHAVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:21:17 -0400
Date: Fri, 7 May 2004 15:34:12 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org,
       vsu@altlinux.ru, "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: [PATCH 2.6] Fix memory leaks in w83781d and asb100
Message-ID: <20040507223412.GH14660@kroah.com>
References: <20040505221804.GE29885@kroah.com> <200405071242.i47CgHPE027360@zone3.gcu-squad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405071242.i47CgHPE027360@zone3.gcu-squad.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 02:42:17PM +0200, Jean Delvare wrote:
> 
> >> Greg, please apply if it looks good to you. Sorry for introducing the
> >> leak in the first place...
> >
> >Looks a bit odd, but ok.
> 
> Odd? Why that? If you can think of something better, just tell me.

No, I couldn't, it's just strange looking code :)

thanks,

greg k-h
