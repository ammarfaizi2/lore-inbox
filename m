Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUHCA1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUHCA1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUHCA1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:27:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:34523 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264648AbUHCA1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:27:09 -0400
Date: Mon, 2 Aug 2004 17:25:37 -0700
From: Greg KH <greg@kroah.com>
To: William Thompson <wt@electro-mechanical.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB quits working on 2.6.7
Message-ID: <20040803002537.GA26323@kroah.com>
References: <20040802194542.GA11965@electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802194542.GA11965@electro-mechanical.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:45:42PM -0400, William Thompson wrote:
> I have USB host controllers and HID compiled in due to the keyboard.

Can you test 2.6.8-rc2 to see if this is fixed there or not?

thanks,

greg k-h
