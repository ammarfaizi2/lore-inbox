Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTJ2P4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 10:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTJ2P4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 10:56:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:7647 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261947AbTJ2P4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 10:56:33 -0500
Date: Wed, 29 Oct 2003 07:55:15 -0800
From: Greg KH <greg@kroah.com>
To: Simon Vogl <vogl@soft.uni-linz.ac.at>
Cc: Burjan Gabor <buga@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 usbserial/pl2303 oops
Message-ID: <20031029155515.GA3457@kroah.com>
References: <20031027083406.GA9326@odin.sis.hu> <20031027234233.GB3408@kroah.com> <20031029001731.GA20355@odin.sis.hu> <3F9F830F.6010803@soft.uni-linz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9F830F.6010803@soft.uni-linz.ac.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 10:06:23AM +0100, Simon Vogl wrote:
> I have a different problem with the pl2303 module, but have
> no clue where to search: I have an ericsson cradle that I
> check repeatedly if a cell phone is plugged in or not.

Does this happen on the latest 2.4.23-pre8 kernel?  Does this happen on
2.6.0-test9?

thanks,

greg k-h
