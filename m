Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270641AbTGNOxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270638AbTGNOws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:52:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29378
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270446AbTGNOvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:51:47 -0400
Subject: Re: -- END OF BLOCK -- (fwd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, marcelo@conectiva.com,
       Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
In-Reply-To: <20030714143613.GA9349@lst.de>
References: <Pine.LNX.4.55L.0307141007560.18257@freak.distro.conectiva>
	 <20030714143613.GA9349@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058195006.561.68.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 16:03:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 15:36, Christoph Hellwig wrote:
> Now it seems Alan merged other stuff without telling the person
> who send him the original patch, thus -ac seems to have code the
> XFS tree and -aa don't have.

Yes I merged the vendor fixes that stopped it hanging machines. I was
suprised you didn't work from that base since that had extensive vendor
tree testing and while it had some uglies which you cleaned up in the
other stuff it would have been a saner base point


