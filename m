Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265855AbUBCGMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 01:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUBCGMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 01:12:31 -0500
Received: from webhost1.sirion.net.au ([203.63.163.20]:25092 "EHLO
	webhost1.sirion.net.au") by vger.kernel.org with ESMTP
	id S265855AbUBCGMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 01:12:30 -0500
In-Reply-To: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au>
References: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E9A39380-560F-11D8-8E3C-000A95CEEE4E@computeraddictions.com.au>
Content-Transfer-Encoding: 7bit
Cc: LinuxSA ML <linuxsa@linuxsa.org.au>, linux-kernel@vger.kernel.org
From: Ryan Verner <xfesty@computeraddictions.com.au>
Subject: Re: Promise PDC20269 (Ultra133 TX2) + Software RAID
Date: Tue, 3 Feb 2004 16:42:15 +1030
To: Ryan Verner <xfesty@computeraddictions.com.au>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2004, at 2:08 PM, Ryan Verner wrote:
> And the machine is randomly locking up, and of course, on reboot, the 
> raid array is rebuilt.  Ouch.  Any clues as to why?  I'm sure the hard 
> drive hasn't failed as it's brand new; I suspect a chipset 
> compatibility problem or something.

Definitely seems to be this.  Swapped the drives back over to the 
onboard-IDE chipset, which is much slower (raid rebuilds at only 
7MB/sec instead of 25), but certainly none of these problems.

Known issue?

R

--

Signature space for rent.

