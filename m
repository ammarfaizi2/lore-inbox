Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUAPISI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 03:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUAPIRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 03:17:49 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:16360 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265314AbUAPIRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 03:17:47 -0500
Subject: Re: [2.4.18]: Reiserfs: vs-2120: add_save_link: insert_item
	returned -28
From: Vladimir Saveliev <vs@namesys.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <200401091622.41352.lkml@kcore.org>
References: <200401091622.41352.lkml@kcore.org>
Content-Type: text/plain
Message-Id: <1074241063.2251.41.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 16 Jan 2004 11:17:43 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Fri, 2004-01-09 at 18:22, Jan De Luyck wrote:
> Hello list,
> 
> Today I discovered I could no longer create files on one of my boxes, which 
> still runs 2.4.18 (box is too far away to upgrade right now). It gives me 
> 'disk full' messages.
> 
> The following message is all over my logs since January 3:
> 
> vs-2120: add_save_link: insert_item returned -28
> 

This is just a warning. You should be able to free some disk space by
removing some files.



> I can't seem to find much on this issue, is this a bug in reiserfs (which is 
> fixed in a later version)? Is something wrong with the fs itself?
> 
> Thanks for answers.
> 
> [I'm not subscribed @ reiserfs-list, so please cc me with answers from that 
> list]
> 
> Jan

