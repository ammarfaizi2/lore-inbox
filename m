Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTFIUgH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTFIUgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:36:06 -0400
Received: from CPE-65-29-18-81.mn.rr.com ([65.29.18.81]:55190 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S261969AbTFIUgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:36:00 -0400
Subject: Re: cachefs on linux
From: Shawn <core@enodev.com>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: "Leonardo H. Machado" <leoh@dcc.ufmg.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030609204249.GA11373@citd.de>
References: <Pine.LNX.4.44.0306091624370.14854-100000@volga.dcc.ufmg.br>
	 <20030609204249.GA11373@citd.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1055191776.13435.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 09 Jun 2003 15:49:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it's a nice way to simulate writing on r/o filesystems IIRC. Like
mounting a cdrom then writing to it, but you're not.

Was that was this was? Anyway, linux also does not have unionFS. If it
was that big of a deal, someone would write it. As it is, it's a
whizbang no one cares about enough.

On Mon, 2003-06-09 at 15:42, Matthias Schniedermeyer wrote:
> On Mon, Jun 09, 2003 at 04:26:01PM -0300, Leonardo H. Machado wrote:
> > 
> > Why has Solaris a CacheFS file system, while linux doesn't?
> 
> Is this a "You don't know it, you don't need it" thing?
> 
> 
> 
> Bis denn
