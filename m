Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319251AbSHUXx6>; Wed, 21 Aug 2002 19:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319254AbSHUXx6>; Wed, 21 Aug 2002 19:53:58 -0400
Received: from codepoet.org ([166.70.99.138]:36573 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S319251AbSHUXx6>;
	Wed, 21 Aug 2002 19:53:58 -0400
Date: Wed, 21 Aug 2002 17:58:08 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
Message-ID: <20020821235808.GA26956@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20020821234411.GA26772@codepoet.org> <Pine.LNX.4.10.10208211648300.10353-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10208211648300.10353-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 21, 2002 at 04:49:37PM -0700, Andre Hedrick wrote:
> 
> Erik,
> 
> I am working on the logic changes in the separtation of code.
> It is very likely I got some thing backwards but it is easy to test.

BTW, I took a look over the ide layer.  Its looking much nicer
already.  BTW CONFIG_BLK_DEV_IDECD_BAILOUT doesn't seem to be
applied to anything at the moment...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
