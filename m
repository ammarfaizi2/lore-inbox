Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTBXWln>; Mon, 24 Feb 2003 17:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTBXWln>; Mon, 24 Feb 2003 17:41:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48646 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261963AbTBXWll>;
	Mon, 24 Feb 2003 17:41:41 -0500
Message-ID: <3E5AA1F6.6060201@pobox.com>
Date: Mon, 24 Feb 2003 17:51:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Shaya Potter <spotter@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: hard lockup on 2.4.20 w/ nfs over frees/wan
References: <1045634189.4761.44.camel@zaphod>	 <1045686971.8084.2.camel@zaphod> <1045757772.31762.13.camel@zaphod>	 <20030220164420.GA9800@gtf.org> <1046124651.10146.1.camel@zaphod>
In-Reply-To: <1046124651.10146.1.camel@zaphod>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter wrote:
> seems to be stable w/ the 2.4.19 driver.  All the tests that I ran be
> (basically kernel building over nfs over ipsec) that hung it hard
> consistently b4 aren't hanging it now.



Thanks.  This tells me what I need to know...

