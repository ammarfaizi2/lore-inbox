Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284963AbRLFD5v>; Wed, 5 Dec 2001 22:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284965AbRLFD5l>; Wed, 5 Dec 2001 22:57:41 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:33290 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284964AbRLFD51>; Wed, 5 Dec 2001 22:57:27 -0500
Message-ID: <3C0EEC6B.7060009@namesys.com>
Date: Thu, 06 Dec 2001 06:56:27 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <E16BpcG-0000mI-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>Hi Hans,
>
>On December 6, 2001 04:41 am, you wrote:
>
>>I can't comment on your benchmarks because I was on the way to bed when 
>>I read this.  I am sure though that you and Stephen are doing your usual 
>>good programming.
>>
>>ReiserFS is an Htree by your definition in your paper, yes?
>>
>
>You've got a hash-keyed b*tree over there.  The htree is fixed depth.
>

B*trees are fixed depth.  B-tree usually means height-balanced.  



Best wishes,

Hans



