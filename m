Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbTCYRhF>; Tue, 25 Mar 2003 12:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbTCYRhF>; Tue, 25 Mar 2003 12:37:05 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:27149 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263208AbTCYRhC>; Tue, 25 Mar 2003 12:37:02 -0500
Date: Tue, 25 Mar 2003 17:48:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Tweedie <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Subject: Re: [Patch 2/8] 2.4: Fix for enormous numbers of buffers on BUF_LOCKED
Message-ID: <20030325174810.A4002@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Tweedie <sct@redhat.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	ext2-devel@lists.sourceforge.net
References: <200303251739.h2PHdeR3006892@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303251739.h2PHdeR3006892@sisko.scot.redhat.com>; from sct@redhat.com on Tue, Mar 25, 2003 at 05:39:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 05:39:40PM +0000, Stephen Tweedie wrote:
> +/*
> + * Do some IO post-processing here!!!

Do we really need to shout at each other !?!?!?!?!?

