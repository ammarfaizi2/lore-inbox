Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbTINRBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 13:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbTINRBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 13:01:24 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:18963 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261220AbTINRBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 13:01:23 -0400
Date: Sun, 14 Sep 2003 19:01:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Justin Cormack <justin@street-vision.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030914190121.G3371@pclin040.win.tue.nl>
References: <1063484193.1781.48.camel@mulgrave> <20030913212723.GA21426@gtf.org> <1063538182.1510.78.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1063538182.1510.78.camel@lotte.street-vision.com>; from justin@street-vision.com on Sun, Sep 14, 2003 at 12:15:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 12:15:27PM +0100, Justin Cormack wrote:

> LABEL= is so broken that I immediately remove it from all my redhat
> systems. It is not unique at all. As soon as you plug another system
> disk into your system at boot time all hell breaks loose. At least it
> could have a random number in it or something.

I do not understand your complaint.
It is you who assigns the label. You can choose whatever label you fancy.
Include any random strings you like.

> If you need to know your bootdisk (why?) why not just get the bootloader
> to tell you?

I am not quite sure why anybody would like to know what the bootdisk was.
The rootdisk, yes, that we need. But the bootdisk?
Finding it is nontrivial in general. Letting the bootloader tell us
is also nontrivial.

