Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265118AbUE0T41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUE0T41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUE0T41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:56:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15593 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265118AbUE0T4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:56:25 -0400
Message-ID: <40B647DB.4090109@pobox.com>
Date: Thu, 27 May 2004 15:56:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org
Subject: Re: [Prism54-devel] Re: [PATCH 0/14] prism54: bring up to sync with
 prism54.org cvs rep
References: <20040524083003.GA3330@ruslug.rutgers.edu> <20040524085727.GR3330@ruslug.rutgers.edu> <40B62F29.6090101@pobox.com> <20040527192733.GB14186@logos.cnet> <40B6424D.7030203@pobox.com> <20040527194513.GV3330@ruslug.rutgers.edu>
In-Reply-To: <20040527194513.GV3330@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:
> Great. I'll fix all those patches up again for you and Marcelo. For future
> development I've asked other prism54 developers to first send patches to

For what it's worth, you may send a "one big patch" to add the driver to 
2.4, since the individual changes to that point will be in 2.6.x 
BitKeeper changelog.

Once the driver is merged, I do request split-up patches just like 2.6.x.


> netdev for review/approval. Maybe we *should* do away with prism54-devel 
> mailing list and just use netdev as was once suggested by someone...

Up to you :)

	Jeff


