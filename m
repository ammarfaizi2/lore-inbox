Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270928AbTHFSqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270930AbTHFSqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:46:38 -0400
Received: from smtp.terra.es ([213.4.129.129]:65385 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S270928AbTHFSqh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:46:37 -0400
Date: Wed, 6 Aug 2003 20:45:14 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-Id: <20030806204514.00c783d8.diegocg@teleline.es>
In-Reply-To: <20030806180427.GC21290@matchmail.com>
References: <3F306858.1040202@mrs.umn.edu>
	<20030805224152.528f2244.akpm@osdl.org>
	<3F310B6D.6010608@namesys.com>
	<20030806183410.49edfa89.diegocg@teleline.es>
	<20030806180427.GC21290@matchmail.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 6 Aug 2003 11:04:27 -0700 Mike Fedyk <mfedyk@matchmail.com> escribió:

> 
> Journaled filesystems have a much smaller chance of having problems after a
> crash.


I've had (several) filesystem corruption in a desktop system with (several)
journaled filesystems on several disks. (They seem pretty stable these days,
though)

However I've not had any fs corrution in ext2; ext2 it's (from my experience)
rock stable.

Personally I'd consider twice the really "serious" option for a serious server.


