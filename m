Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUAIWDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUAIWDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:03:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27840 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264539AbUAIWDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:03:49 -0500
Message-ID: <3FFF252A.2020103@pobox.com>
Date: Fri, 09 Jan 2004 17:03:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Whiting <ewhiting@amis.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: e1000 in 2.6.1-mm1 -- still broken?
References: <3FFF147E.F68F246D@amis.com>
In-Reply-To: <3FFF147E.F68F246D@amis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Whiting wrote:
> I'm having trouble with e1000 in -mm1. (works in 2.6.1) The device is detected
> and shows up and can be configured, but nothing ever goes out on the wire. 


Should be fixed when akpm updates the e1000 patch to

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.1-netdrvr-exp1.patch.bz2
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.1-netdrvr-exp1.log

