Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTICRbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTICRbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:31:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33550 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264123AbTICRbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:31:41 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Quota Hash Abstraction 2.6.0-test2
Date: 3 Sep 2003 17:23:00 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bj581k$81r$1@gatekeeper.tmr.com>
References: <20030731184341.GA21078@www.13thfloor.at> <bj4vfq$6to$1@gatekeeper.tmr.com> <20030903161435.GC24897@DUK2.13thfloor.at>
X-Trace: gatekeeper.tmr.com 1062609780 8251 192.168.12.62 (3 Sep 2003 17:23:00 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030903161435.GC24897@DUK2.13thfloor.at>,
Herbert Poetzl  <herbert@13thfloor.at> wrote:
| On Wed, Sep 03, 2003 at 02:56:58PM +0000, bill davidsen wrote:
| > In article <20030731184341.GA21078@www.13thfloor.at>,
| > Herbert =?iso-8859-1?Q?P=F6tzl?=  <herbert@13thfloor.at> wrote:
| > 
| > Is any of this, particularly the work mentioned in the last paragraph
| > getting into the mail kernel?
| 
| the quota fix was included in the next (test) release
| so default quota will work again ...

Thanks for the quick response, that was my prime concern. I expect to
need quota again in the near future.
| 
| the Quota Hash Abstraction is neither a (big) performance
| gain nor a feature bonus for the end user ... it is more
| an enhancement to the code itself, allowing to have more
| than one quota hash for arbitrary purposes ...
| 
| I doubt, that this code will ever make it into mainline
| without another 'good' reason to use it, but maybe the
| --bind mount quota stuff would be such a reason, if the 
| interest for such things will eventually grow ...
| 
| HTH,
| Herbert

Big help, I have never had a performance problem with the quota stuff
other than not performing at all ;-) Good to have the code handy though,
use often follows capability rather than drives it.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
