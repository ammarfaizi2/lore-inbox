Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263209AbTCNBfc>; Thu, 13 Mar 2003 20:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263210AbTCNBfc>; Thu, 13 Mar 2003 20:35:32 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:29429 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S263209AbTCNBfb>; Thu, 13 Mar 2003 20:35:31 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20 instability on bigmem systems?
Date: Thu, 13 Mar 2003 17:45:28 -0800
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <20030314004256.GI20188@holomorphy.com>
In-Reply-To: <20030314004256.GI20188@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303131745.28683.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 16:42, William Lee Irwin III wrote:
> > Full details are at
> > http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.20
>
> Hmm, slabinfo would be very helpful, as well as meminfo.

I'll have to schedule a reboot into that kernel, but I'll try to get it 
tonight if at all possible.

> You might need bh stuff (memclass-related or something like it) if it's
> general disk io. Can't be too sure until slabinfo + meminfo materialize.

I'm not familiar with "bh"... where can I read up on what it is?

Thanks again,
Gregory

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

