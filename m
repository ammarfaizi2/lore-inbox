Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284926AbRLFNqR>; Thu, 6 Dec 2001 08:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285111AbRLFNqH>; Thu, 6 Dec 2001 08:46:07 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:23045 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284926AbRLFNqA>; Thu, 6 Dec 2001 08:46:00 -0500
Message-ID: <3C0F7659.1090701@namesys.com>
Date: Thu, 06 Dec 2001 16:44:57 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16BpcG-0000mI-00@starship.berlin> <3C0EEC6B.7060009@namesys.com> <E16Bppx-0000mN-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On December 6, 2001 04:56 am, Hans Reiser wrote:
>
>>>On December 6, 2001 04:41 am, you wrote:
>>>
>>>>ReiserFS is an Htree by your definition in your paper, yes?
>>>>
>>>You've got a hash-keyed b*tree over there.  The htree is fixed depth.
>>>
>>B*trees are fixed depth.  B-tree usually means height-balanced.  
>>
>
>I was relying on definitions like this:
>
>  B*-tree
>
>  (data structure)
>
>  Definition: A B-tree in which nodes are kept 2/3 full by redistributing
>  keys to fill two child nodes, then splitting them into three nodes.
>

This is the strangest definition I have read.  Where'd you get it?

>
>
>To tell the truth, I haven't read your code that closely, sorry, but I got 
>the impression that you're doing rotations for balancing no?  If not then 
>

What are rotations?

>
>have you really got a b*tree?
>
>--
>Daniel
>
>



