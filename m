Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277791AbRJLRTW>; Fri, 12 Oct 2001 13:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277788AbRJLRTM>; Fri, 12 Oct 2001 13:19:12 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:30902
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S277781AbRJLRSw>; Fri, 12 Oct 2001 13:18:52 -0400
Date: Fri, 12 Oct 2001 13:18:44 -0400
From: Chris Mason <mason@suse.com>
To: Tom Rini <trini@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: reiserfs-list <reiserfs-list@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: Linux 2.4.12-ac1
Message-ID: <1822570000.1002907124@tiny>
In-Reply-To: <20011012083616.C9992@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011012072910.N21564@cpe-24-221-152-185.az.sprintbbd.net> <E15s44B-0007Vk-00@the-village.bc.nu> <20011012083616.C9992@cpe-24-221-152-185.az.sprintbbd.net>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, October 12, 2001 08:36:16 AM -0700 Tom Rini <trini@kernel.crashing.org> wrote:

> On Fri, Oct 12, 2001 at 04:17:39PM +0100, Alan Cox wrote:
>> > On Fri, Oct 12, 2001 at 02:17:26PM +0100, Alan Cox wrote:
>> > 
>> > > 2.4.12-ac1
>> > > o	Merge the majority of 2.4.11/12
>> > > 	-	Fall back to the Linus reiserfs code set
>> > [snip]
>> > 
>> > The endian-safe patches will come back tho, right?  I don't think those
>> > have made it into Linus' tree yet...
>> 
>> Really what needs to happen is the important bits that were tested and
>> the reiser folks were happy with get pushed back bit by bit into both trees
>> now
> [reiserfs list added to cc]
> 
> That would be nice.  Are there any plans on behalf of the reiserfs
> people to merge in the Endian-Safeness patches now?

Jeff had sent them to linus before 2.4.10 came out, and again 
earlier this week.  Hopefully they'll make it into 2.4.13pre.

-chris

