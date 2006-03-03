Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWCCRiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWCCRiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWCCRiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:38:51 -0500
Received: from mail.dvmed.net ([216.237.124.58]:55437 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750791AbWCCRiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:38:50 -0500
Message-ID: <44087F28.6030506@garzik.org>
Date: Fri, 03 Mar 2006 12:38:48 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcos Luiggi Lemos Sartori <marlls1989@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Software Emulation Layer
References: <44087BF5.90003@gmail.com>
In-Reply-To: <44087BF5.90003@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcos Luiggi Lemos Sartori wrote:
> I have an Idea that could be good to you propuse to the Developers.
> 
> I think that all unixs most have a universal binarie (kind you compile
> Bash on a BSD and you can run on Linux, Solaris... Without recompile
> it), so my Idea is create a plugable automatic kernel Level emulation
> for aliens binaries, and root threes for the aliens systems libraries
> (such Libc).

Just define your own ABI.

Linux and *BSD already support foreign ABIs.

	Jeff



