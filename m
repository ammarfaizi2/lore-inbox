Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263773AbTJ0XnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbTJ0XnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:43:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:12741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263773AbTJ0XnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:43:04 -0500
Date: Mon, 27 Oct 2003 15:42:34 -0800
From: Greg KH <greg@kroah.com>
To: Burjan Gabor <buga@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 usbserial/pl2303 oops
Message-ID: <20031027234233.GB3408@kroah.com>
References: <20031027083406.GA9326@odin.sis.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027083406.GA9326@odin.sis.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 09:34:06AM +0100, Burjan Gabor wrote:
> Hi,
> 
> [1.] One line summary of the problem:
> 
> Kernel oops related to emulated(?) serial device using pl2303 and pppd.

Can you try 2.4.23-pre8 and see if that fixes your problem?

thanks,

greg k-h
