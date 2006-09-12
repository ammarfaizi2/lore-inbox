Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWILRhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWILRhW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWILRhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:37:22 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:47246 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030290AbWILRhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:37:21 -0400
In-Reply-To: <4506AF06.8040303@s5r6.in-berlin.de>
References: <1158031971.5057@shark.he.net> <Pine.LNX.4.61.0609120906540.6283@yvahk01.tjqt.qr> <4506AF06.8040303@s5r6.in-berlin.de>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E2B418E8-801F-44DC-AC1D-AE1EFA8DF310@kernel.crashing.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Randy Dunlap <rdunlap@xenotime.net>, Victor Hugo <victor@vhugo.net>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] e-mail clients
Date: Tue, 12 Sep 2006 19:34:59 +0200
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Truncating whitespace at EOL is a good thing.
> [...]
>
> Trailing whitespace should be removed before generating the patch, not
> while sending the patch.

And not even then, when the patch is removing trailing
whitespace :-)


Segher

