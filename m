Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTDZGJI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 02:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264614AbTDZGJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 02:09:08 -0400
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:53942 "EHLO
	renegade") by vger.kernel.org with ESMTP id S263775AbTDZGJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 02:09:07 -0400
Date: Fri, 25 Apr 2003 23:21:05 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ChangeLog suggestion
Message-ID: <20030426062105.GA1423@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Marcelo,

In each changelog entry, it would be really useful to include the
Message-ID of that email in a regex-parsable location. This way, if the
email was cced to lkml it would be possible for folks to track down the
actual patch.

I'm not familiar with your scripts, but I'd be surprised if this were very
difficult to implement. At the same time, there are many cases of changelog
entries that read only 'USB' or something equally unhelpful, where there is
little chance that anyone could track down the corresponding patch.  Having the
Message-ID in those cases would make all the difference in the world.

Be well,
Zack

-- 
Zack Brown
