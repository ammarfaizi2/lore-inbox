Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTI1RCT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbTI1RCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:02:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8890 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262627AbTI1RCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:02:18 -0400
Message-ID: <3F77140E.2080402@pobox.com>
Date: Sun, 28 Sep 2003 13:02:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [bk patches] 2.6.x misc updates
References: <20030928144428.GA16477@gtf.org> <20030928164002.GA4931@redhat.com>
In-Reply-To: <20030928164002.GA4931@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sun, Sep 28, 2003 at 10:44:28AM -0400, Jeff Garzik wrote:
>  > 
>  > Linus, please do a
>  > 
>  > 	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.5
>  > 
>  > This will update the following files:
>  > 
>  >    * char/agp/amd64-agp: properly suffix 64-bit constants
> 
> Please don't touch this. It needs fixing in a different way
> for 32bit.


I don't see how the patch could break anything.  It's obviously correct, 
even if the overall code isn't great for IA32.

	Jeff



