Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRLWUiP>; Sun, 23 Dec 2001 15:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278522AbRLWUiG>; Sun, 23 Dec 2001 15:38:06 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:23686 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S280132AbRLWUhz>;
	Sun, 23 Dec 2001 15:37:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Date: Sun, 23 Dec 2001 12:37:49 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011222164602.A20623@Sophia.soo.com> <20011223151147.F7438@suse.de> <20011223120825.A22239@Sophia.soo.com>
In-Reply-To: <20011223120825.A22239@Sophia.soo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16IFNW-0003Dm-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 23, 2001 09:08, really mason_at_soo_dot_com wrote:
> Yikes, hope not.  But yeps, i'm using IDE drives,
> ATA100 master and ATA66 slave.  It's a VIA vt8233
> south bridge.  i also have the FSB overclocked so
> the PCI bus is running at 37mhz.  That's caused
> no trouble so far.

I saw mild disk corruption with a VT82C686B and AT33 master (it's a AT100 
drive with a 40w cable ;) in 2.5.2pre1. Same setup works fine with 2.4.17, no 
overclocking.

-Ryan
