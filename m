Return-Path: <linux-kernel-owner+w=401wt.eu-S932494AbWLLW0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWLLW0k (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWLLW0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:26:40 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:62117 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932494AbWLLW0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:26:39 -0500
Message-ID: <457F2CBA.8010904@cfl.rr.com>
Date: Tue, 12 Dec 2006 17:27:06 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: Andrew Robinson <andrew.rw.robinson@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with
 SATA and should not be used by any meansis not stable with SATA and should
 not be used by any means)
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com> <457F02D3.5010004@cfl.rr.com> <457F0F7D.9090207@wolfmountaingroup.com>
In-Reply-To: <457F0F7D.9090207@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2006 22:26:54.0337 (UTC) FILETIME=[A0863710:01C71E3C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14868.003
X-TM-AS-Result: No--15.385800-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No.  I still see corruption on Suse with Reiser FS.  It's always very 
> subtle (like the last block of a file doesn;t get copied or gets
> corrupted.   We have been running our ftp server on ReiserFS, and as 
> soon as I can get it moved back to ext3, we are doing so.
> We have had a lot of issues with corrupted RPM files and builds on 
> ReiserFS.  If you can get the files copied to the
> FS ok, they seem to stay that way.  moving a lot of data with recursive 
> copies seems troublesome and some of the files
> seem to get the ends clipped off of them.

If your comment here was in reply to my general comment about resierfs 
stability and not the specific hibernation issue the OP was having, 
please edit the quote down to just that portion instead of quoting the 
entire message, including the quotes it was replying to.

I wonder what kernel version you are running.  Since you mention rpms, I 
will assume you are running redhat, and likely are using a rather old 
kernel.


