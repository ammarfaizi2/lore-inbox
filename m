Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTKXHep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 02:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTKXHep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 02:34:45 -0500
Received: from terminus.zytor.com ([63.209.29.3]:11242 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263611AbTKXHeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 02:34:44 -0500
Message-ID: <3FC1B48B.8090403@zytor.com>
Date: Sun, 23 Nov 2003 23:34:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: data from kernel.bkbits.net
References: <20031124051910.GA2766@work.bitmover.com>
In-Reply-To: <20031124051910.GA2766@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> I've been trying to get all the data off the drives on the machine which
> was broken into.  I have a feeling that whoever this was was hiding stuff
> in the file system because both drives will not fsck clean nor will they
> completely read.
> 
> I've managed to get most of the data off but not all.  Given that I've put
> about 3 days into this I'm pretty much done.  If someone else wants to look
> at the drives I can make them available, let me know.  But just reading the
> main drive makes the kernel (Fedora 1) kill the tar process as below (it
> also managed to wack the system enough that it overwrote the NVRAM with
> garbage).  It hasn't been a fun weekend.
> 

Looks more like a 3Ware driver bug to me.  Hard to say for sure, though.

	-hpa

