Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268669AbTCCRsT>; Mon, 3 Mar 2003 12:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268684AbTCCRsS>; Mon, 3 Mar 2003 12:48:18 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:24073 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268669AbTCCRsR>; Mon, 3 Mar 2003 12:48:17 -0500
Date: Mon, 3 Mar 2003 17:58:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5-bk menuconfig format problem
Message-ID: <20030303175844.A29121@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <3E637196.8030708@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E637196.8030708@walrond.org>; from andrew@walrond.org on Mon, Mar 03, 2003 at 03:15:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 03:15:34PM +0000, Andrew Walrond wrote:
> Just done a pull and now the first entry of make menuconfig is:
> 
>   [*] Support for paging of anonymous memory
> 
> It shouldn't really be there, should it?

Why not?  Even if you never want to use a swapless kernel there's still
plenty use for it.

