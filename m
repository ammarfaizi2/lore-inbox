Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283342AbRK2RVv>; Thu, 29 Nov 2001 12:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283340AbRK2RVm>; Thu, 29 Nov 2001 12:21:42 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:21509 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S283331AbRK2RV1>; Thu, 29 Nov 2001 12:21:27 -0500
Message-ID: <3C066E78.6060208@namesys.com>
Date: Thu, 29 Nov 2001 20:20:56 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: en-us
MIME-Version: 1.0
To: jd@epcnet.de
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: statfs and reiserfs
In-Reply-To: <24719656.avixxmail@nexx.epcnet.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

we believe we are following the official standard.  If you find we err 
on this, let us know, but I think we used to set the fields to 0 and 
then found out it should be -1.

Hans



