Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284140AbRLKWYT>; Tue, 11 Dec 2001 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284143AbRLKWYJ>; Tue, 11 Dec 2001 17:24:09 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:33551 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284140AbRLKWYB>;
	Tue, 11 Dec 2001 17:24:01 -0500
Date: Wed, 12 Dec 2001 09:17:47 +1100
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: axboe@suse.de, plars@austin.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Scsi problems in 2.5.1-pre9
Message-ID: <20011211221747.GB30520@krispykreme>
In-Reply-To: <20011211164744.GC13498@suse.de> <20011211165426.GD13498@suse.de> <20011211212802.GA30520@krispykreme> <20011211.140409.21593464.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011211.140409.21593464.davem@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> In that case you perhaps should be defining DMA_CHUNK_SIZE in
> asm/dma.h :-)

Hmm I have it defined, just not in dma.h :) I'll fix it now and retest.

Anton
