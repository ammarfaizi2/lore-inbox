Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTEUIVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTEUHwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:52:07 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261561AbTEUHnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:43:11 -0400
Date: Tue, 20 May 2003 21:21:53 -0700
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       Oliver Neukum <oliver@neukum.org>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030521042153.GB9057@kroah.com>
References: <20030517090705.GA16092@zax> <20030517103037.GA17576@ranty.ddts.net> <20030520052158.GD5248@zax> <20030520080740.GB26921@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520080740.GB26921@ranty.ddts.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 10:07:40AM +0200, Manuel Estrada Sainz wrote:
>  What do you guys thing is best?
> 
>  a) loading
>  b) control
>  c) other:_____

d) Don't care.

"loading" or "control" is fine with me, as long as it's documented :)

thanks,

greg k-h
