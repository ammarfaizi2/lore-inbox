Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289422AbSAOJUN>; Tue, 15 Jan 2002 04:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289446AbSAOJUD>; Tue, 15 Jan 2002 04:20:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24849 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289422AbSAOJT6>;
	Tue, 15 Jan 2002 04:19:58 -0500
Date: Tue, 15 Jan 2002 10:19:51 +0100
From: Jens Axboe <axboe@suse.de>
To: David Dyck <dcd@tc.fluke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2 / IDE cdrom_read_intr: data underrun / end_request: I/O error
Message-ID: <20020115101951.A31257@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201120834140.672-100000@dd.tc.fluke.com> <Pine.LNX.4.33.0201141938480.214-100000@dd.tc.fluke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201141938480.214-100000@dd.tc.fluke.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14 2002, David Dyck wrote:
> 
> I'm still getting data underrun errors using 2.5.2
> that don't occur using 2.4.18-pre3.

I'll check up on that, mind checking when this happened exactly in the
2.5 series?

-- 
Jens Axboe

