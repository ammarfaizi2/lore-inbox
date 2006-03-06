Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWCFQN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWCFQN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWCFQN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:13:28 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:4480 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1750783AbWCFQN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:13:27 -0500
Date: Mon, 6 Mar 2006 19:13:24 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060306191324.A1502@jurassic.park.msu.ru>
References: <20060304111219.GA10532@localhost> <20060306155114.A8425@jurassic.park.msu.ru> <20060306135434.GA12829@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060306135434.GA12829@localhost>; from mchouque@free.fr on Mon, Mar 06, 2006 at 02:54:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 02:54:34PM +0100, Mathieu Chouquet-Stringer wrote:
> Too bad my alpha doesn't support SRM (it's really a modified LX164
> board).
> 
> Is there anything I can do to help debug the problem?

No, thanks. I've finally found the AlphaBIOS ROM image for lx164,
that was most difficult part of the work. ;-)
Now I'm able to kill the box in just one second with 'ping -f'...
Will look into this tomorrow.

Ivan.
