Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTETBMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTETBMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:12:20 -0400
Received: from web40607.mail.yahoo.com ([66.218.78.144]:59210 "HELO
	web40607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263311AbTETBMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:12:19 -0400
Message-ID: <20030520012512.38960.qmail@web40607.mail.yahoo.com>
Date: Mon, 19 May 2003 18:25:12 -0700 (PDT)
From: lars hofhansl <lhofhansl@yahoo.com>
Subject: RE: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
To: "Mudama, Eric" <eric_mudama@maxtor.com>,
       Tomas Szepe <szepe@pinerecords.com>
Cc: Jeffrey Baker <jwbaker@acm.org>, linux-kernel@vger.kernel.org
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D3AB@mcoexc04.mlm.maxtor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No hdparm does not allow me to.
I can't check the exact error msg right now (at work),
but previous messages in this thread have it.

-- Lars


--- "Mudama, Eric" <eric_mudama@maxtor.com> wrote:
> 
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> 
> I think that is the offending line?
> 
> can you enable DMA transfer modes on the drive using
> hdparm?
> 
> --eric
> 

[ lots of other discussion deleted ]


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
