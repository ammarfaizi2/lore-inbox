Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUC1WgM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUC1WgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 17:36:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42979 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262448AbUC1WgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 17:36:10 -0500
Message-ID: <4067534B.70807@pobox.com>
Date: Sun, 28 Mar 2004 17:35:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: silverbanana@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: Re: usage of RealTek 8169 crashes my Linux system
References: <40673495.3050500@gmx.de> <4067378B.7070102@pobox.com> <4067489E.2090400@gmx.de>
In-Reply-To: <4067489E.2090400@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Fuhrmann wrote:
> Jeff Garzik wrote:
> 
>> Does Andrew Morton's -mm patches fix it for you?
> 
> 
> I haven't tried them yet, because I haven't seen any changes in the 
> recent mm-patches to that r8169 driver (just checked all the 
> announce.txt files of 2.6.5-rc1&2). Maybe I missed something.
> 
> If you think one of these patches might fix it (please tell me the exact 
> patch number) I will apply and test it as soon as possible.


Andrew's -mm patches include my -netdev queue, which in turn includes a 
rather large and much-needed r8169 update.

	Jeff



