Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUC2V0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbUC2V0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:26:08 -0500
Received: from dsl081-235-061.lax1.dsl.speakeasy.net ([64.81.235.61]:17829
	"EHLO ground0.sonous.com") by vger.kernel.org with ESMTP
	id S262954AbUC2V0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:26:03 -0500
In-Reply-To: <1080595343.3570.15.camel@laptop.fenrus.com>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <1080594005.3570.12.camel@laptop.fenrus.com> <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com> <1080595343.3570.15.camel@laptop.fenrus.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ACFAE876-81C7-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Lev Lvovsky <lists1@sonous.com>
Subject: Re: older kernels + new glibc?
Date: Mon, 29 Mar 2004 13:26:00 -0800
To: arjanv@redhat.com
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 29, 2004, at 1:22 PM, Arjan van de Ven wrote:

> On Mon, 2004-03-29 at 23:09, Lev Lvovsky wrote:
>> We have the source of the drivers, but they are specific to the 2.2.x
>> kernels.  I am not a kernel hacker, and this would be way beyond my
>> area of expertise.
>>
>> And sadly, this doesn't answer the initial question.
>
> then to answer your question; at compile time you tell glibc what
> minimum kernel version it can assume, and based on that glibc will
> enable/disable certain features. So it depends on what your distro
> supplied there if it'll work or not. if you tell glibc that at minimum
> you do 2.4.1 for example, then no a 2.2 kernel won't work. I think most
> distros do this (or an even later version) since a few years now.

perfect - where does this variable get set?  sorry for what now seems 
like OT glibc stuff.

thanks,
-lev

