Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTAVCuX>; Tue, 21 Jan 2003 21:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTAVCuX>; Tue, 21 Jan 2003 21:50:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:55021 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267285AbTAVCuX>;
	Tue, 21 Jan 2003 21:50:23 -0500
Date: Tue, 21 Jan 2003 18:59:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why isn't quota dependant on ext2?
Message-Id: <20030121185927.3abd9298.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301212046260.5472-100000@innerfire.net>
References: <Pine.LNX.4.44.0301212046260.5472-100000@innerfire.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2003 02:59:24.0136 (UTC) FILETIME=[44C4CE80:01C2C1C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack <gmack@innerfire.net> wrote:
>
> Anyone know why the quota menu option isn't dependant on ext2 since that's
> all it works with?
> 

ext3, ufs and udf also use the core quota code.


