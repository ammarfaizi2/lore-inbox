Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317672AbSGOV44>; Mon, 15 Jul 2002 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317671AbSGOV4z>; Mon, 15 Jul 2002 17:56:55 -0400
Received: from [213.225.90.118] ([213.225.90.118]:16138 "HELO
	lexx.infeline.org") by vger.kernel.org with SMTP id <S317672AbSGOV4y>;
	Mon, 15 Jul 2002 17:56:54 -0400
Date: Mon, 15 Jul 2002 23:59:48 +0200 (CEST)
From: Ketil Froyn <ketil-kernel@froyn.net>
X-X-Sender: ketil@lexx.infeline.org
To: "Patrick J. LoPresti" <patl@curl.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <s5g7kjwsn12.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.44.0207152356430.19217-100000@lexx.infeline.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jul 2002, Patrick J. LoPresti wrote:

> Without calling fsync(), you *never* know when the data will hit the
> disk.

Doesn't bdflush ensure that data is written to disk within 30 seconds or 
some tunable number of seconds?

Ketil

