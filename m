Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130456AbQJ0NMa>; Fri, 27 Oct 2000 09:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130534AbQJ0NMV>; Fri, 27 Oct 2000 09:12:21 -0400
Received: from zeus.kernel.org ([209.10.41.242]:29194 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130456AbQJ0NMP>;
	Fri, 27 Oct 2000 09:12:15 -0400
Date: Fri, 27 Oct 2000 14:10:06 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Juri Haberland <juri.haberland@innominate.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Quota fixes and a few questions
Message-ID: <20001027141006.Q20050@redhat.com>
In-Reply-To: <20000927145620.B8484@atrey.karlin.mff.cuni.cz> <20001007003134.B4732@redhat.com> <news2mail-39EAE3A3.7D08CD8B@innominate.de> <news2mail-39EF0906.E7281F12@innominate.de> <20001019190354.A15755@atrey.karlin.mff.cuni.cz> <20001020154204.A1863@redhat.com> <39F94B8F.C2293ADD@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39F94B8F.C2293ADD@innominate.de>; from juri.haberland@innominate.de on Fri, Oct 27, 2000 at 11:31:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 27, 2000 at 11:31:59AM +0200, Juri Haberland wrote:
> > 
> Hi Stephen,
> 
> unfortunately 0.0.3b has the same problem. I tried it with a stock
> 2.2.17 kernel + NFS patches + ext3-0.0.3b and the quota rpm you
> included. Extracting two larger tar.gz files hits the deadlock reliably.

OK, will try to replicate.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
