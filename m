Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261662AbSJQDCK>; Wed, 16 Oct 2002 23:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSJQDCK>; Wed, 16 Oct 2002 23:02:10 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:12166
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S261662AbSJQDCJ>; Wed, 16 Oct 2002 23:02:09 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Simon Roscic <simon.roscic@chello.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210161838.39824.simon.roscic@chello.at>
References: <200210152120.13666.simon.roscic@chello.at>
	 <1034744519.29307.26.camel@localhost>
	 <200210161838.39824.simon.roscic@chello.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034824086.32333.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 22:08:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you actually get the lockups then?

On Wed, 2002-10-16 at 11:38, Simon Roscic wrote:
> On Wednesday 16 October 2002 07:02, GrandMasterLee <masterlee@digitalroadkill.net> wrote:
> > Do you use LVM, EVMS, MD, other, or none?
> >
> 
> none.
> it's a XFS filesystem with the folowing mount options:
> rw,noatime,logbufs=8,logbsize=32768
> 
> (this apply's to all 3 machines)
> 
> simon.
> (please CC me, i'm not subscribed to lkml)
> 
