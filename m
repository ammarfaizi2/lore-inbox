Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289032AbSAIVqi>; Wed, 9 Jan 2002 16:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289033AbSAIVqb>; Wed, 9 Jan 2002 16:46:31 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:19404 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S289032AbSAIVqR>;
	Wed, 9 Jan 2002 16:46:17 -0500
Date: Wed, 9 Jan 2002 16:46:37 -0500
Subject: Re: 2.4.8 fs corruption and subsequent fs problems with links
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: linux-kernel@vger.kernel.org
To: "B. Wehrle" <bwehrle@u.washington.edu>
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <3C3C2686.52491F7@u.washington.edu>
Message-Id: <5B9AA50E-054A-11D6-91AF-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday, January 9, 2002, at 06:16 AM, B. Wehrle wrote:

> Using debugfs I can see that the file thinks it holds inode 0!
> The only way to fix the problem is to wipe out XFree86.0.log using the
> kill command in debugfs (using / mounted RO).

Do you do a fsck -f after debugfs? Is it still good then?

Oh, yeh, and do you have a backup? Now might be the time....

