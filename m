Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTGGVA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTGGVA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:00:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47280 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264328AbTGGVA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:00:58 -0400
Message-ID: <3F09E2E7.7020500@pobox.com>
Date: Mon, 07 Jul 2003 17:15:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Torri <storri@sbcglobal.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unable to grab 2.5 tree via bkbits
References: <1057610739.11432.18.camel@base>
In-Reply-To: <1057610739.11432.18.camel@base>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Torri wrote:
> I am trying to grab the kernel via bk but I am not able to find the
> rigth directory. My first attempt was as follows:
> 
> 
>>$ bk clone http://linux.bkbits.net/linux-2.5 linux-2.5
> 
> Clone http://linux.bkbits.net/linux-2.5 -> file://usr/src/linux-2.5
> linux-2.5: No such file or directory
> 
> Yet when I when I viewed the hosted projects at www.bkbits.net I noticed
> that there was a linus project for the kernel. So I tried that:
> 
> 
>>$ bk clone http://linus.bkbits.net/linux-2.5 linux-2.5
> 
> Clone http://linus.bkbits.net/linux-2.5 -> file://usr/src/linux-2.5
> linux-2.5: No such file or directory
> 
> So far I see no messages that alert me to a problem with bkbits.net so I
> am suspecting the problem is on my end. Can someone show me the errors
> of my ways?


Just to verify, I'm definitely able to pull and clone from 
http://linux.bkbits.net/linux-2.5 ...  I even cut-n-pasted your first 
command line to be sure.

It sounds like a local problem... disk space?  no rights to write to curdir?

	Jeff



