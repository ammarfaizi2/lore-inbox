Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRB1XiP>; Wed, 28 Feb 2001 18:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129389AbRB1XiG>; Wed, 28 Feb 2001 18:38:06 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:14600 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129381AbRB1Xhy>;
	Wed, 28 Feb 2001 18:37:54 -0500
Date: Wed, 28 Feb 2001 18:37:52 -0500
From: Zach Brown <zab@zabbo.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_dma_set_mask()
Message-ID: <20010228183752.C25968@tetsuo.zabbo.net>
In-Reply-To: <20010228103727.I23735@tetsuo.zabbo.net> <3A9D26A2.14563DE1@mandrakesoft.com> <20010228161450.A25553@tetsuo.zabbo.net> <15005.34953.909874.589120@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <15005.34953.909874.589120@pizda.ninka.net>; from davem@redhat.com on Wed, Feb 28, 2001 at 03:23:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 03:23:53PM -0800, David S. Miller wrote:

> Jeff/Zach, I agree, I'm fully for such a patch, but please update the
> documentation!  It is the most important part of the patch.

Very good point.  I'll add Jeff's error returning and spin some minor
docs and resend.

thanks.
