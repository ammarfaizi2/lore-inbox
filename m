Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272148AbTG2VSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTG2VSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:18:43 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:38286 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S272148AbTG2VLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:11:11 -0400
Date: Tue, 29 Jul 2003 17:11:09 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-ID: <20030729211108.GA6500@washoe.rutgers.edu>
References: <20030729153114.GA30071@washoe.rutgers.edu> <20030729135025.335de3a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729135025.335de3a0.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Andrew for replying

On Tue, Jul 29, 2003 at 01:50:25PM -0700, Andrew Morton wrote:

> > Buffer I/O error on device hda2, logical block 3861506
> Odd.
> What filesystem types are in use?
ext3 only 

> Are you using some sort of initrd setup?
not to my knowledge :-)

> Could you please run with this patch, send the traces?
sure - will be done


                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
