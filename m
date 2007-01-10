Return-Path: <linux-kernel-owner+w=401wt.eu-S964983AbXAJSTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbXAJSTp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbXAJSTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:19:44 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:44855 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964983AbXAJSTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:19:44 -0500
Message-ID: <45A52E3D.20005@garzik.org>
Date: Wed, 10 Jan 2007 13:19:41 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
References: <45A3FF32.1030905@wolfmountaingroup.com> <200701101829.32369.prakash@punnoor.de> <20070110174710.GL17267@csclub.uwaterloo.ca> <200701101856.07137.prakash@punnoor.de>
In-Reply-To: <200701101856.07137.prakash@punnoor.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Am Mittwoch 10 Januar 2007 18:47 schrieb Lennart Sorensen:
>> On Wed, Jan 10, 2007 at 06:29:28PM +0100, Prakash Punnoor wrote:
>>> You can install the Intel Matrix driver after "adjusting" the inf file...
>> Hmm, I guess a good question is: Why should I have to edit the inf file?
>> Is it an issue of them making it only install if your hardware is
>> already set to ahci mode?  But how am I supposed to boot and install the
>> driver until I have the driver installed then.  Well I might try that
>> next time I go there.  How stupid of intel.
> 
> Intel wants you to buy hw with ICH8R. ICH8 isn't get the advanced features for 
> free....

What advanced features do you claim are missing from ICH8?

The 'R' indicates software RAID, provided by BIOS and a software driver. 
  Which uses the standard AHCI programming interface.  ICH8 provides 
AHCI, just like ICH8R does.

	Jeff



