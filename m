Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269634AbUHZUsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269634AbUHZUsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUHZUi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:38:59 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:42422 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269622AbUHZUfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:35:11 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Rik van Riel <riel@redhat.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1093552515.5678.93.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 16:35:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 07:42, Rik van Riel wrote:
> On Thu, 26 Aug 2004, Denis Vlasenko wrote:
> 
> > > I like cat < a > b. You can keep your progress.
> > 
> > cat <a >b does not preserve following file properties even on standard
> > UNIX filesystems: name,owner,group,permissions.
> 
> Losing permissions is one thing.  Annoying, mostly.
> 

cat <a >b does preserve permissions - the permissions of b.  I always
considered this a feature.

Lee

