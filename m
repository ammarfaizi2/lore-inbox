Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUCVPfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUCVPfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:35:24 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:52237 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262064AbUCVPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:35:20 -0500
Date: Mon, 22 Mar 2004 15:35:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@suse.de>, Heikki Tuuri <Heikki.Tuuri@innodb.com>,
       linux-kernel@vger.kernel.org
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040322153511.A21143@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@suse.de>, Heikki Tuuri <Heikki.Tuuri@innodb.com>,
	linux-kernel@vger.kernel.org
References: <023001c4100e$c550cd10$155110ac@hebis> <20040322132307.GP1481@suse.de> <20040322151712.GB32519@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040322151712.GB32519@merlin.emma.line.org>; from matthias.andree@gmx.de on Mon, Mar 22, 2004 at 04:17:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 04:17:12PM +0100, Matthias Andree wrote:
> If there is no such atomicity (except maybe in ext3fs data=journal or
> the upcoming reiserfs4 - isn't there?), then nobody should claim so. If
> the kernel cannot 100.00000000% guarantee the write is atomic, claiming
> otherwise is plain fraud and nothing else.

Who claims writes are atomic?

