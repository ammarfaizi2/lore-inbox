Return-Path: <linux-kernel-owner+w=401wt.eu-S1751181AbXAFE5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbXAFE5U (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 23:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbXAFE5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 23:57:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:42234 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbXAFE5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 23:57:20 -0500
Date: Fri, 5 Jan 2007 20:51:47 -0800
From: Greg KH <greg@kroah.com>
To: Yakov Lerner <iler.ml@gmail.com>
Cc: Kernel Linux <linux-kernel@vger.kernel.org>
Subject: Re: how to get serial_no from usb HD disk (HDIO_GET_IDENTITY ioctl, hdparm -i)
Message-ID: <20070106045147.GA6081@kroah.com>
References: <f36b08ee0701041427u7aee90b7j46b06c3b7dd252bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36b08ee0701041427u7aee90b7j46b06c3b7dd252bd@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 12:27:34AM +0200, Yakov Lerner wrote:
> How can I get serial_no from usb-attached HD drive ?

use the *_id programs that come with udev, they show you how to properly
do that.

good luck,

greg k-h
