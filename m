Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265120AbRF0SDx>; Wed, 27 Jun 2001 14:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbRF0SDn>; Wed, 27 Jun 2001 14:03:43 -0400
Received: from james.kalifornia.com ([208.179.59.2]:42043 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265120AbRF0SDb>; Wed, 27 Jun 2001 14:03:31 -0400
Message-ID: <3B3A1F4A.1080603@kalifornia.com>
Date: Wed, 27 Jun 2001 11:00:42 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010625
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Marty Leisner <leisner@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: mounting a fs in two places at once?
In-Reply-To: <200106250212.WAA05336@soyata.home> <3B370250.1050305@kalifornia.com> <20010628004854.B7331@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Mon, Jun 25, 2001 at 02:20:16AM -0700, Ben Ford wrote:
>
>>Feature.  It actually makes it quite nice when you want to allow
>>chrooted user(s) access to a common directory, you just mount a
>>partition in all the users home dirs.
>>
>
>For security, this can be a bad idea.
>

'tis very true.

I have been using this for FTP users, such as allowing a common /mp3 
download directory relative to each users jail.  That is what I was 
referring to, should have been more specific.

-b

-- 
:    __o
:   -\<,
:   0/ 0
-----------



