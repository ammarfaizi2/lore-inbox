Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbREXVQu>; Thu, 24 May 2001 17:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbREXVQk>; Thu, 24 May 2001 17:16:40 -0400
Received: from quattro.sventech.com ([205.252.248.110]:59148 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S262290AbREXVQ2>; Thu, 24 May 2001 17:16:28 -0400
Date: Thu, 24 May 2001 17:16:27 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Prasanna P Subash <psubash@turbolinux.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon on 2.2.19 ?
Message-ID: <20010524171627.D26439@sventech.com>
In-Reply-To: <20010522182740.A3125@turbolinux.com> <E152toh-0004uo-00@the-village.bc.nu> <20010524123030.B3485@turbolinux.com> <20010524153653.A26439@sventech.com> <20010524141351.C3485@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010524141351.C3485@turbolinux.com>; from Prasanna P Subash on Thu, May 24, 2001 at 02:13:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001, Prasanna P Subash <psubash@turbolinux.com> wrote:
> Without the patch below the boot up would hang right after it detected the
> ide devices.
> 
> After applying the patch it booted all the way but the keyboard would hang.
> 
> BTW I'm trying to port this patch back to the 2.2.18 TL-Kernel. Are there
> anymore changes I have to look at ?

There were 2 patches. The one that went into 2.2.20-pre1 (not the patch
you just sent) and the patch you just sent. You need both.

JE

