Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbSJQGaw>; Thu, 17 Oct 2002 02:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261825AbSJQGaw>; Thu, 17 Oct 2002 02:30:52 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:53979 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261824AbSJQGav>; Thu, 17 Oct 2002 02:30:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <baldrick@wanadoo.fr>
To: John Levon <levon@movementarian.org>
Subject: Re: Use of yield() in the kernel
Date: Thu, 17 Oct 2002 08:36:29 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200210151536.39029.baldrick@wanadoo.fr> <20021015171250.GB25538@compsoc.man.ac.uk>
In-Reply-To: <20021015171250.GB25538@compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210170836.29584.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 19:12, John Levon wrote:
> On Tue, Oct 15, 2002 at 03:36:38PM +0200, Duncan Sands wrote:
> > fs/locks.c
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103352923323135&w=2
>
> I don't think the maintainer has submitted a patch for it yet.

A fix has been applied in Linus's tree.  See

http://linux.bkbits.net:8080/linux-2.5/cset@1.781.27.3?nav=index.html|ChangeSet@-3d

Duncan.
