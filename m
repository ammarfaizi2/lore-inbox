Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRDJLAd>; Tue, 10 Apr 2001 07:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRDJLAX>; Tue, 10 Apr 2001 07:00:23 -0400
Received: from kamov.deltanet.ro ([193.226.175.59]:16902 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S131244AbRDJLAG>;
	Tue, 10 Apr 2001 07:00:06 -0400
Date: Tue, 10 Apr 2001 13:59:47 +0300
To: Jakub Jelinek <jakub@redhat.com>
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] amusing copy_from_user bug
Message-ID: <20010410135947.I3497@ppetru.net>
In-Reply-To: <200104101011.DAA29579@csl.Stanford.EDU> <20010410064128.C1169@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010410064128.C1169@devserv.devel.redhat.com>; from jakub@redhat.com on Tue, Apr 10, 2001 at 06:41:28AM -0400
From: ppetru@ppetru.net (Petru Paler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 06:41:28AM -0400, Jakub Jelinek wrote:
> some architectures don't care at all, because verify_area is a noop
> (sparc64).

Why (and how) is this?

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
