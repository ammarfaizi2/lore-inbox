Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268452AbUIQAGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbUIQAGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 20:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIQAF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 20:05:56 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:50312 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268206AbUIQACO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 20:02:14 -0400
Subject: Re: [PATCH] Suspend2 Merge: Supress various actions/errors while
	suspending [0/5]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916170017.0f14d202.akpm@osdl.org>
References: <1095378659.5897.96.camel@laptop.cunninghams>
	 <20040916170017.0f14d202.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1095379419.5902.112.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 10:03:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-09-17 at 10:00, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> >
> > The following patches suppress various actions and errors while we're
> > suspending.
> 
> Sorry, I'm not in a position to merge all this stuff up.
> 
> There's a significant rewrite of the suspend code in -mm and we're having
> trouble getting that merged up because Pat has limited time to work on
> these things.
> 
> Until we get the existing rework settled and Pat has time to look at
> suspend2 I'd rather not have to take it on.

Fair enough. Shall I just post the remainder to LKML for now, get it
reviewed and apply the changes? Then, when everyone is happy and Patrick
has done his stuff, I could simply ask you to pull from
suspend.bkbits.net.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

