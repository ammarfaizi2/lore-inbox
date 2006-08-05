Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161435AbWHEB3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbWHEB3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 21:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161501AbWHEB3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 21:29:30 -0400
Received: from thunk.org ([69.25.196.29]:41639 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161435AbWHEB33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 21:29:29 -0400
Date: Fri, 4 Aug 2006 21:28:54 -0400
From: Theodore Tso <tytso@mit.edu>
To: Eric Sandeen <esandeen@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jack@suse.cz, neilb@suse.de,
       Marcel Holtmann <marcel@holtmann.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [patch 16/23] ext3: avoid triggering ext3_error on bad NFS file handle
Message-ID: <20060805012854.GA23326@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Eric Sandeen <esandeen@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
	alan@lxorguk.ukuu.org.uk, jack@suse.cz, neilb@suse.de,
	Marcel Holtmann <marcel@holtmann.org>,
	"Stephen C. Tweedie" <sct@redhat.com>
References: <20060804053258.391158155@quad.kroah.org> <20060804054010.GQ769@kroah.com> <44D35DA0.4060403@redhat.com> <20060804145254.GA20640@infradead.org> <44D36946.7020601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D36946.7020601@redhat.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:35:34AM -0500, Eric Sandeen wrote:
> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
> 
> (tho blatantly ripped off from Neil Brown's ext2 patch)

Looks good!

Acked-by: "Theodore Ts'o" <tytso@mit.edu>

					- Ted
