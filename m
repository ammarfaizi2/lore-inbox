Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVARVPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVARVPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVARVPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:15:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59828 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261425AbVARVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:15:02 -0500
Message-ID: <41ED7C38.3080201@pobox.com>
Date: Tue, 18 Jan 2005 16:14:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Martins Krikis <mkrikis@yahoo.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: iswraid and 2.4.x?
References: <41ED56B5.8000603@pobox.com>	 <20050118195621.15879.qmail@web30202.mail.mud.yahoo.com> <58cb370e050118125536c17538@mail.gmail.com>
In-Reply-To: <58cb370e050118125536c17538@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Tue, 18 Jan 2005 11:56:21 -0800 (PST), Martins Krikis
> <mkrikis@yahoo.com> wrote:
> 
>>--- Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>>
>>>Check your inbox from months ago ;-)  AFAICS his current version
>>>addresses all the comments from Alan and myself, from when it hit
>>>lkml 6
>>>months(?) ago...
>>>
>>>I'll give it another quick lookover though, sure.
>>
>>Jeff,
>>
>>As long as 2.4.30 is planned at all, I have no more
>>worries for the moment. But if so, then please don't
>>waste your time looking over the current version. In
>>about a week there should really be another one out.
>>It will add RAID10, and get rid of the "claim disks
>>for RAID" mis-feature. I'll let everybody know, of course.
> 
> 
> I'm just curious.  Is there already a possibility to use
> RAID10 metadata in 2.6.x kernels?

Intel or 'md' metadata?

You need dmraid to use the Intel proprietary format.  I'm not sure if it 
supports RAID10 yet, but it supports the other levels.

	Jeff



