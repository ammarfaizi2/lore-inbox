Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbULZUag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbULZUag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 15:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbULZUaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 15:30:35 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:17811 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261152AbULZUaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 15:30:19 -0500
In-Reply-To: <Pine.LNX.4.61.0412261124220.17702@montezuma.fsmlabs.com>
References: <1104077531.5268.32.camel@mulgrave> <20041226162727.GA27116@work.bitmover.com> <1104079394.5268.34.camel@mulgrave> <20041226171900.GA27706@work.bitmover.com> <Pine.LNX.4.61.0412261124220.17702@montezuma.fsmlabs.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F3086B9A-577C-11D9-BCB8-000A95E3BCE4@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Larry McVoy <lm@bitmover.com>
From: Martin Dalecki <martin@dalecki.de>
Subject: Re: [BK] disconnected operation
Date: Sun, 26 Dec 2004 21:30:14 +0100
To: Zwane Mwaikambo <zwane@fsmlabs.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-26, at 19:41, Zwane Mwaikambo wrote:

> On Sun, 26 Dec 2004, Larry McVoy wrote:
>
>> On Sun, Dec 26, 2004 at 10:43:13AM -0600, James Bottomley wrote:
>>> On Sun, 2004-12-26 at 08:27 -0800, Larry McVoy wrote:
>>>> I suspect that your hostname changes when you disconnect.  Leases 
>>>> are
>>>> issued on a per host basis.  If you make your hostname constant when
>>>> you unplug it should work.  If it doesn't, let us know.
>>>
>>> Well, that's a new one, but no, I have a fixed hostname which dhcp is
>>> forbidden from changing.
>>
>> Let's do a little poll here to find out if it is specific to you or if
>> this is a problem that everyone is having.  Could we get people who
>> use BK disconnected to stand up and be counted?  Does this work for
>> anyone?
>
> I use it whilst on travel too, however i do not have a similar problem 
> as
> described by James but i've noticed that simple operations like `bk vi
> filename` take extremely long;

There are very few name-service implementations out there with proper
error handling out there. Sad world this is ;-) ...

