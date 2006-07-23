Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWGWJMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWGWJMy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 05:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWGWJMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 05:12:54 -0400
Received: from anubis.lpbproductions.com ([38.119.36.60]:49322 "EHLO
	anubis.lpbproductions.com") by vger.kernel.org with ESMTP
	id S1751165AbWGWJMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 05:12:54 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: Hans Reiser <reiser@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Date: Sun, 23 Jul 2006 02:12:54 -0700
User-Agent: KMail/1.9.1
Cc: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com>
In-Reply-To: <44C32348.8020704@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607230212.55293.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 12:20 am, Hans Reiser wrote:
> I just got an email from the programmer who wrote the MythTV bug saying
> that he is just too busy to bother fixing the bug in his code.....  so
> my response is that a Namesys programmer is going to fix it on Monday.

The way you wrote this, makes it sound like a userspace issue, and _not_ a 
problem with reiserfs.

> And look at how Linus abandoned 2.4!  Users of 2.4 needed so many
> features that were put into 2.6 instead, and they were just abandoned
> and neglected and....  Do you think he will abandon 2.6.18 also?

Not entirely true, he did not abandon the 2.4 kernel branch, he passed on 
maintainership to Marcelo. Similar to how he passed the torch on the 2.2 
kernel branch to Alan Cox. Also on a side note, many new features ( and a ton 
of bug fixes !! ) were added to the 2.4 series _after_ Linus started working 
on the 2.5 branch.







