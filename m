Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRDTWZU>; Fri, 20 Apr 2001 18:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132077AbRDTWY7>; Fri, 20 Apr 2001 18:24:59 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:56337 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S132072AbRDTWY7>; Fri, 20 Apr 2001 18:24:59 -0400
Message-ID: <3AE0B8CD.2040704@eisenstein.dk>
Date: Sat, 21 Apr 2001 00:31:41 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: Wayne.Brown@altec.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Current status of NTFS support
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Wayne.Brown@altec.com wrote:

> 
> Where does write support for NTFS stand at the moment? 

> 
I'll let someone who knows about that answer that part ;)

> Also, I'll have to recreate my Linux partitions after the upgrade.  Does anyone
> know if FIPS can split a partition safely that was created under Windows
> 2000/NT?  It worked fine for Windows 98, but I'm a little worried about what
> might happen if I try to use it on an NTFS partition.
> 
Last time I checked (about 2 months ago) FIPS was not able to work with 
NTFS partitions - you'll probably have to use Partition Magic or 
something similar to modify the NTFS partition (but why not just create 
the NTFS partition of a smaller size and then use the unpartitioned 
space for a ext2 partition?).

Best regards,
Jesper Juhl - juhl@eisenstein.dk

