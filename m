Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbTHORVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270082AbTHORTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:19:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:36067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270013AbTHORTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:19:25 -0400
Date: Fri, 15 Aug 2003 10:16:36 -0700
From: Greg KH <greg@kroah.com>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to run 2.6.0-test3
Message-ID: <20030815171636.GA3129@kroah.com>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:11:42PM +0900, Norman Diamond wrote:
> 
> 2.  When I attach a USB hard disk drive, 2.6.0 drivers log the following:
> [...] no runnable /etc/hotplug/scsi_device.agent is installed
> 2.4.19 didn't have this problem.  2.4.19 automatically updated /etc/fstab.

Try getting the latest update of the hotplug scripts from
http://linux-hotplug.sf.net/ if you don't like seeing this in your log
files.  It's a very harmless message.

thanks,

greg k-h
