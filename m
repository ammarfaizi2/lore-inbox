Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTBQOgr>; Mon, 17 Feb 2003 09:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTBQOgq>; Mon, 17 Feb 2003 09:36:46 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:21011 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267229AbTBQOKn>; Mon, 17 Feb 2003 09:10:43 -0500
Date: Mon, 17 Feb 2003 14:20:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Miles Bader <miles@gnu.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Make sysctl vm subdir dependent on CONFIG_MMU
Message-ID: <20030217142035.A26454@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miles Bader <miles@gnu.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030217105900.5E2683728@mcspd15.ucom.lsi.nec.co.jp> <20030217125504.A25066@infradead.org> <20030217140944.GA21202@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030217140944.GA21202@gnu.org>; from miles@gnu.org on Mon, Feb 17, 2003 at 09:09:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 09:09:44AM -0500, Miles Bader wrote:
> Either way is OK with me, but note that I just followed the style already
> used in sysctl.c for CONFIG_NET.

Looks like I need to fix up that bad example :)

