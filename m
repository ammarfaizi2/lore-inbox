Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289950AbSAWSHu>; Wed, 23 Jan 2002 13:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289954AbSAWSHk>; Wed, 23 Jan 2002 13:07:40 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:26567 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S289950AbSAWSHZ>; Wed, 23 Jan 2002 13:07:25 -0500
Date: Wed, 23 Jan 2002 13:08:42 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: find a file containing a specific sector
In-Reply-To: <20020123120055.A14311@helium.inexs.com>
Message-ID: <Pine.LNX.4.33.0201231308070.24338-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I know the sector and lbasector, can I determine the inode and/or
> the actual file affected?

probably makes more sense to just "e2fsck -c".

