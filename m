Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVEGKwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVEGKwg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 06:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVEGKwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 06:52:36 -0400
Received: from mail.portrix.net ([212.202.157.208]:38103 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262959AbVEGKwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 06:52:35 -0400
Message-ID: <427C9DBD.1030905@ppp0.net>
Date: Sat, 07 May 2005 12:51:41 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050331 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk>
In-Reply-To: <20050506235842.A23651@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Mar 04, 2005 at 11:36:26AM +0000, Russell King wrote:
> 
>>On Fri, Mar 04, 2005 at 03:26:32AM -0800, Andrew Morton wrote:
>>
>>>Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>>>
>>>>On Wed, Mar 02, 2005 at 08:38:12PM -0800, Andrew Morton wrote:
>>>> > Grump.  Have all these regressions received the appropriate level of
>>>> > visibility on this mailing list?
>>>>
>>>> Looking at the http://l4x.org/k/ site, it appears that all -mm versions
>>>> have broken ARM support with the defconfig, while Linus kernels at least
>>>> build fine.

Sorry for tapping in so late. I don't follow lkml that close. For some time
I thought about providing semi-automatic mails of what architectures broke/
got fixed from one version to another, tracking mm/rc/git(?). Would that
be useful?

-- 
Jan
