Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264399AbRFONMa>; Fri, 15 Jun 2001 09:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264401AbRFONMT>; Fri, 15 Jun 2001 09:12:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:38115 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264399AbRFONMJ>; Fri, 15 Jun 2001 09:12:09 -0400
Subject: Re: [Jfs-discussion] Re: severe FS corruption with 2.4.6-pre2 + IBM jfs 0.3.4
 patch
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jfs-discussion@dwoss.lotus.com,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>,
        David Mansfield <lkml@dm.ultramaster.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF336B3F96.2AD61AA8-ON85256A6C.0047D9E1@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 15 Jun 2001 08:11:54 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 06/15/2001 09:11:54 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 01:55:05AM Andi Kleen wrote:
> On Thu, Jun 14, 2001 at 02:25:06PM -0400, Jeff Garzik wrote:
>> Alan Cox wrote:
>> >
>> > > It's probably a JFS issue, but I thought I'd report this in case
someone
>> > > is collecting and correlating filesystem corruption messages
(Alan?).
>> > > Here is my sad story.
>> >
>> > I get as far as 'using jfs' and delete them
>>
>> Understandable but FWIW they have apparently passed a night of
>> stress-kernel (cerberus) testing on the latest jfs..

> rm -rf not working correctly is a kind of show stopper bug ATM though.
> Hopefully it can be fixed soon.

Andi,

The rm -rf problem is our topic priority and should be fixed in less
that a week.

Steve

