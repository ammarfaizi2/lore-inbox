Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTATNer>; Mon, 20 Jan 2003 08:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbTATNer>; Mon, 20 Jan 2003 08:34:47 -0500
Received: from angband.namesys.com ([212.16.7.85]:19946 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265815AbTATNeq>; Mon, 20 Jan 2003 08:34:46 -0500
Date: Mon, 20 Jan 2003 16:43:44 +0300
From: Oleg Drokin <green@namesys.com>
To: venom@sns.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with kernel 2.5.59
Message-ID: <20030120164344.A2377@namesys.com>
References: <Pine.LNX.4.43.0301201418180.1075-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0301201418180.1075-100000@cibs9.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jan 20, 2003 at 02:23:58PM +0100, venom@sns.it wrote:
> I was using reiserFS for the root FS on a desktop, just to test kernel 2.5.59,
> and I started to get those messages:
> PAP-14030: direct2indirect: pasted or inserted byte exists in the tree [5094
> 5096 0x1001 IND]. Use fsck to repair.
> Of course I repaired the FS.

Was the FS clean before you started to use 2.5.59?

Bye,
    Oleg
