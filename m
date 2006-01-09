Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWAISZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWAISZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWAISZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:25:33 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:34963 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S964913AbWAISZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:25:32 -0500
Message-ID: <43C29316.4080300@wolfmountaingroup.com>
Date: Mon, 09 Jan 2006 09:45:10 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Neukum <oliver@neukum.org>, Lee Revell <rlrevell@joe-job.com>,
       Bernd Petrovitsch <bernd@firmix.at>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
 can't for a long time
References: <5t06S-7nB-15@gated-at.bofh.it>	 <1136824149.5785.75.camel@tara.firmix.at>	 <1136824880.9957.55.camel@mindpipe>  <200601091753.36485.oliver@neukum.org> <1136827900.6659.66.camel@localhost.localdomain>
In-Reply-To: <1136827900.6659.66.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2006-01-09 at 17:53 +0100, Oliver Neukum wrote:
>  
>
>>Does the Windows Explorer draw icons based only on name and metadata?
>>    
>>
>
>Sort of. It also plays tricks on the human by working out what icons are
>visible and loading those first then filling in while the user thinks it
>is ready
>
>  
>

And the mouse driver is biased to always get access to CPU cycles so the 
cursor will always be visible
and working even when the system is totally locked up.  NTFS performance 
is also totally abysimal
when volumes reach 2TB sizes due to fragmentation of the NTFS 
archtiecture.  A problem not shared
with EXT3 FS's.

J

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

