Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUD2DL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUD2DL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUD2DL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:11:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:5290 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263059AbUD2DLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:11:07 -0400
Date: Wed, 28 Apr 2004 20:10:40 -0700
From: Greg KH <greg@kroah.com>
To: Bryan Small <code_smith@comcast.net>
Cc: Sean Young <sean@mess.org>, Chester <fitchett@phidgets.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Message-ID: <20040429031040.GA5336@kroah.com>
References: <20040428181806.GA36322@atlantis.8hz.com> <80928E9A-9983-11D8-9ADE-000A95B17CC2@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80928E9A-9983-11D8-9ADE-000A95B17CC2@comcast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 10:18:28PM -0400, Bryan Small wrote:
>   Really cool Sean. I am currently working on the IfKit for both the 
> 8/8/8 and the 0/8/8 on the textlcds. Also working on the textlcds 
> output.

What kernel/userspace interface were you going to use?  Or are you using
a pure libusb/usbfs type interface?

> If I get these done soon was thinking of moving to RFID, so that we can 
> also possibly throw in Chesters PAM auth module idea in.

That is a cool project, again, what kind of kernel interaction would you
want for it?

thanks,

greg k-h
