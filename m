Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318733AbSHERdd>; Mon, 5 Aug 2002 13:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318738AbSHERdb>; Mon, 5 Aug 2002 13:33:31 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:52996 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318733AbSHERdb>; Mon, 5 Aug 2002 13:33:31 -0400
Date: Mon, 5 Aug 2002 18:37:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] write_super is not for syncing (take 3)
Message-ID: <20020805183704.A18612@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
References: <1028568893.1805.270.camel@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028568893.1805.270.camel@tiny>; from mason@suse.com on Mon, Aug 05, 2002 at 01:34:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 01:34:53PM -0400, Chris Mason wrote:
> Below are just the hunks that change VFS code, against 2.4.19-final. 
> The reiserfs bits will come once this gets accepted.  Please review and
> throw something blunt at me if you don't want this in the kernel.

Could you please get that tested in 2.5 or -ac first?

