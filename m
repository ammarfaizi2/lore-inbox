Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271265AbRHOQW5>; Wed, 15 Aug 2001 12:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271268AbRHOQWr>; Wed, 15 Aug 2001 12:22:47 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:33287 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S271265AbRHOQWh>; Wed, 15 Aug 2001 12:22:37 -0400
Date: Wed, 15 Aug 2001 18:22:23 +0200
From: Kurt Roeckx <Q@ping.be>
To: =?iso-8859-1?Q?David_G=F3mez?= <davidge@jazzfree.com>
Cc: ext3-users@redhat.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: vfat is not working with ext3 patch
Message-ID: <20010815182223.A573@ping.be>
In-Reply-To: <Pine.LNX.4.33.0108151736510.518-100000@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <Pine.LNX.4.33.0108151736510.518-100000@fargo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 05:49:05PM +0200, David Gómez wrote:
> 
> Hi all,
> 
> My system is :
> kernel 2.4.8 with ext3-0.9.6 patch
> e2fsprogs-1.22-2, mount-2.11g, util-linux-2.11f

I have e2fsprogs 1.22, and util-linux 2.11h, but doubt it has
much to do with it.

> And ext3 filesystem works fine, but when a vfat partition is mounted:
> everything looks ok till I try to access that partition. A 'cd' to the
> directory /mnt/tmp causes an error of 'not a directory' so i can't access
> to vfat partition.

Works fine here.


Kurt

