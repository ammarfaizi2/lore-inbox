Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTFFPIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTFFPIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:08:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44945
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261864AbTFFPID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:08:03 -0400
Subject: Re: [PATCH] License issue with rocket driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: support@comtrol.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
In-Reply-To: <20030606094759.GA20229@lst.de>
References: <20030606094759.GA20229@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054912734.17185.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jun 2003 16:18:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-06 at 10:47, Christoph Hellwig wrote:
> drivers/char/rocket{,_int}.h have an intereesting and gpl-incompatible
> license.  Could you please fix it or remove the drier from the tree?
> (given that mess that this driver is the latter might be the better
> idea..)

Ditto for 2.4 it appears. Marcelo can you rm the comtrol driver pending
clarification. I'll do the same for 2.2, and Linus needs to pull it for
2.5

