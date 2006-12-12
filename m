Return-Path: <linux-kernel-owner+w=401wt.eu-S932483AbWLLWgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWLLWgD (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWLLWgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:36:03 -0500
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:42861 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932483AbWLLWfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:35:53 -0500
Message-ID: <457F2A47.3080708@wolfmountaingroup.com>
Date: Tue, 12 Dec 2006 15:16:39 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Andrew Robinson <andrew.rw.robinson@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with
 SATA and should not be used by any meansis not stable with SATA and should
 not be used by any means)
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com> <457F02D3.5010004@cfl.rr.com> <457F0F7D.9090207@wolfmountaingroup.com> <457F2CBA.8010904@cfl.rr.com>
In-Reply-To: <457F2CBA.8010904@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:

> If your comment here was in reply to my general comment about resierfs 
> stability and not the specific hibernation issue the OP was having, 
> please edit the quote down to just that portion instead of quoting the 
> entire message, including the quotes it was replying to.
>
> I wonder what kernel version you are running.  Since you mention rpms, 
> I will assume you are running redhat, and likely are using a rather 
> old kernel.
>
The system I see these problems on is a Suse 10.0.  I STORE RPM's on a 
Reiser FS system on this server as an ftp server.  It's the server at 
ftp.soleranetworks.com.  I run 2.6.18 and 2.6.19 for our development at 
present for our appliances, we do not ship Suse.  Our appliances use 
RedHat ES4 and FC6.  We were testing Suse out as an FTP server -- its 
not very stable.  The Suse system with ReiserFS is running 2.6.13.

Jeff
