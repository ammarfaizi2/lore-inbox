Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbTCTEH1>; Wed, 19 Mar 2003 23:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbTCTEH1>; Wed, 19 Mar 2003 23:07:27 -0500
Received: from terminus.zytor.com ([63.209.29.3]:59863 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S261339AbTCTEH0>; Wed, 19 Mar 2003 23:07:26 -0500
Message-ID: <3E794108.3020608@zytor.com>
Date: Wed, 19 Mar 2003 20:18:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: mirrors <mirrors@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
References: <3E78D0DE.307@zytor.com> <3E78ED9F.2060300@zytor.com> <3690000.1048132594@[10.10.2.4]>
In-Reply-To: <3690000.1048132594@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>OK, there seems to be enough resistance to this to put it off for a year
>>or two.  Since that means I don't have to do any work, that plan has
>>inherent appeal to me.
>>
>>In other words, the current setup will remain for now.  HOWEVER, I would
>>like to recommend that mirror sites start carrying .bz2 files if they
>>want to carry only one format.
> 
> 
> Can we at least switch the default upload format to bz2? I would think
> that's a reasonably simple change to the robot? For those of us
> uploading stuff over a slow modem link, the extra efficiency would be
> much appreciated.
> 

No, I don't want to muck with working scripts.  I suggest setting up a 
script to upload to the /staging area and convert automatically.  I have 
put a script called bz2togz in /usr/local/bin to help out.

	-hpa


