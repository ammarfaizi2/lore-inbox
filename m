Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRBLA5d>; Sun, 11 Feb 2001 19:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRBLA5X>; Sun, 11 Feb 2001 19:57:23 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:4358 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130105AbRBLA5T>; Sun, 11 Feb 2001 19:57:19 -0500
Date: Sun, 11 Feb 2001 19:56:11 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Daniel Stone <daniel@kabuki.eyep.net>
cc: Chris Wedgwood <cw@f00f.org>, David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>,
        Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <107980000.981939371@tiny>
In-Reply-To: <3A86387B.D3142DD9@namesys.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, February 11, 2001 10:00:11 AM +0300 Hans Reiser
<reiser@namesys.com> wrote:

> Daniel Stone wrote:
>> 
>> On 11 Feb 2001 02:02:00 +1300, Chris Wedgwood wrote:
>> > On Thu, Feb 08, 2001 at 05:34:44PM +1100, Daniel Stone wrote:
>> > 
>> >     I run Reiser on all but /boot, and it seems to enjoy corrupting my
>> >     mbox'es randomly.
>> > 
>> > what kind of corruption are you seeing?
>> 
>> Zeroed bytes.
> 
> This sounds like the same bug as the syslog bug, please try to help Chris
> reproduce it.
> 
> zam, if Chris can't reproduce it by Monday, please give it a try.
> 

I had a bunch of scripts running over the weekend to try and reproduce
this, but the results were ruined when a major storm killed the power (no,
still haven't gotten around to configuring my UPS to shut things down ;-).

So, I'll try again.

-chris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
