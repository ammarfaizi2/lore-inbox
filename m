Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281266AbRKLGDP>; Mon, 12 Nov 2001 01:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281268AbRKLGDG>; Mon, 12 Nov 2001 01:03:06 -0500
Received: from codepoet.org ([166.70.14.212]:39742 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S281266AbRKLGCy>;
	Mon, 12 Nov 2001 01:02:54 -0500
Date: Sun, 11 Nov 2001 23:02:57 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Maxwell Spangler <maxwax@mindspring.com>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
Message-ID: <20011111230256.A23068@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Maxwell Spangler <maxwax@mindspring.com>, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011109162028.A14567@codepoet.org> <Pine.LNX.4.33.0111111420410.17275-100000@tyan.doghouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111111420410.17275-100000@tyan.doghouse.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Nov 11, 2001 at 02:24:27PM -0500, Maxwell Spangler wrote:
> 
> I've got the same setup and things work fine.  Do you have the "Special UDMA
> feature" enabled in the Promise driver configuration portion of the kernel
> config?  Perhaps it specifically needs that while any other EIDE driver (like
> the embedded PIIX4) would already use DMA..

I had PDC202XX enabed in my kernel for my target, but had stupidly 
forgotten to enable it in the kernel I was running my tests on.

A voice booms: "You feel foolish. Goodbye level 3!",

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
