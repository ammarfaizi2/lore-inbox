Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbTI0QLS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 12:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTI0QLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 12:11:18 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:40630 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262484AbTI0QLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 12:11:17 -0400
Message-ID: <3F75B6A5.4070505@backtobasicsmgmt.com>
Date: Sat, 27 Sep 2003 09:11:17 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Kochanowicz <michal@michal.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: What to use with 2.6.x instead of iproute2?
References: <20030927151935.GD5956@wieszak.lan>
In-Reply-To: <20030927151935.GD5956@wieszak.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Kochanowicz wrote:

> Hi!
> 
> It seems that iproute2 is not maintained any more and it doesn't build
> with kernel 2.6.0-test5.
> 
> What tool one should use to set the interfaces, bridges and such up on
> 2.6.x kernels?
> 
> Regards

Using the patches from RedHat's iproute2 SRPM I can build iproute2 
against 2.6.0-test5 headers with no problems, and it works. With TC 
support, even.

