Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVARR2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVARR2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 12:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVARR2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 12:28:21 -0500
Received: from web30208.mail.mud.yahoo.com ([68.142.200.91]:58999 "HELO
	web30208.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261390AbVARR2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 12:28:17 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=YsFnYumZKgSwiTx5aEJ7Yx6GOzqU22I3REv+KY4K1nhYQUp1OeLO3mxdBSs7g6uIFPpCL/zH1Rb4kffrClWhJmQ7VWTkJfKCEw0OdJ2O3mPliKV6cpHm1uVcZwGIym/fLLD9n4ndDKPhfgdFusoDfMZg1/mcLx5rsnAF1rbBgWU=  ;
Message-ID: <20050118172816.21090.qmail@web30208.mail.mud.yahoo.com>
Date: Tue, 18 Jan 2005 09:28:16 -0800 (PST)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: iswraid and 2.4.x?
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041011111943.GA32430@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> It seems the general consensus is to merge iswraid, so I'm fine with
> it.
> 
> Martins, we are approaching -rc stage, I would prefer the merge to
> happen 
> at the beginning of 2.4.29-pre. Is that fine for you?

Marcelo,

I seemed to have missed the 2.4.29-pre stages, unfortunately.
Are you planning on a 2.4.30, too? I'd still love to get
iswraid accepted in the 2.4 tree eventually...

The version that's out on SourceForge right now would be alright
as is with the 2.4.29-x kernels, if that's any help. In about a
week I'm planning to have a new version that adds RAID10 support
for the ICH7R-based machines. Please let me know what my options
are (if any) regarding getting iswraid in 2.4.

Thanks very much,

  Martins Krikis
  Storage Components Division
  Intel Massachusetts


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
