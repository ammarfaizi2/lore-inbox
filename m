Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289412AbSAOElO>; Mon, 14 Jan 2002 23:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289413AbSAOElE>; Mon, 14 Jan 2002 23:41:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:29446 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289412AbSAOEkr>; Mon, 14 Jan 2002 23:40:47 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jan 2002 20:46:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.2
In-Reply-To: <Pine.LNX.4.33.0201141840070.2544-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0201142042570.935-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Linus Torvalds wrote:

>
> Ok, lots of various changes between 2.5.1->2, mainly in bio, kdev_t and
> scheduler (and several USB updates).

Linus, i've a weird behavior with 2.5.2
swapon first fails at boot ( early stage ) then it succeed ( late boot
stage ) but the swap is not actually activated. Running swapon by hand it
reports a seccessful operation but the swap is not on.
I'm trying to understand what is happening ...




- Davide


