Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbTJPTAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTJPTAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:00:53 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:54535
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263079AbTJPTAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:00:52 -0400
Subject: Re: Transparent compression in the FS
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: John Bradford <john@grabjohn.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, val@nmt.edu
In-Reply-To: <Pine.LNX.4.53.0310161453240.814@chaos>
References: <1066163449.4286.4.camel@Borogove>
	 <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com>
	 <20031016162926.GF1663@velociraptor.random>
	 <20031016172930.GA5653@work.bitmover.com>
	 <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk>
	 <Pine.LNX.4.53.0310161453240.814@chaos>
Content-Type: text/plain
Message-Id: <1066330835.5398.74.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Thu, 16 Oct 2003 15:00:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 14:56, Richard B. Johnson wrote:

> No! Not true. 'lossy' means that you can't recover the original
> data. Some music compression and video compression schemes are
> lossy. If you can get back the exact input data, it's not lossy.

...and with an N-bit hash of M bits of data, where N<M, you cannot
recover the original data...

	Robert Love


