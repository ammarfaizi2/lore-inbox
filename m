Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWELQww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWELQww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWELQwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:52:51 -0400
Received: from jacks.isp2dial.com ([64.142.120.55]:1028 "EHLO
	jacks.isp2dial.com") by vger.kernel.org with ESMTP id S1750702AbWELQwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:52:51 -0400
From: John Kelly <jak@isp2dial.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
Date: Fri, 12 May 2006 12:52:55 -0400
Message-ID: <200605121652.k4CGqniH005122@isp2dial.com>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net> <20060511175143.GH25646@redhat.com> <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr> <200605121619.k4CGJCtR004972@isp2dial.com> <Pine.LNX.4.58.0605121222070.5579@gandalf.stny.rr.com> <200605121630.k4CGUuiU005025@isp2dial.com> <20060512164034.GK7646@smtp.west.cox.net>
In-Reply-To: <20060512164034.GK7646@smtp.west.cox.net>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Hard2Crack: 0.001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006 09:40:34 -0700, Tom Rini
<trini@kernel.crashing.org> wrote:

>On Fri, May 12, 2006 at 12:31:02PM -0400, John Kelly wrote:
>> On Fri, 12 May 2006 12:24:40 -0400 (EDT), Steven Rostedt
>> <rostedt@goodmis.org> wrote:
 
>> >> >Sorry for falling in late but we can't do that.
>> >> >Win 98 (95 too?) shared can not be mounted with CIFS, it requires SMBFS.

>> >> W98?  He's dead, Jim.

>> >huh, my wife has a laptop that she still uses that has w98 on it. And I do
>> >use smbfs to sometimes communicate with it.

>> Users who need vintage features can use vintage kernels.  They haven't
>> been pulled off the market.

>Having a shiny new storage box in my house that just might need to talk
>with old laptops and new laptops and so on doesn't exactly jive with
>that.

If every hypothetical user has to die off before old features are
culled from the kernel, it will become a mountain of old stinking
garbage.


>Of course perhaps this will cause someone who does care about smbfs to
>setup up to the plate and maintain it.

Then let them maintain it out of tree.  People have to maintain new
features out of tree, why not old too?


