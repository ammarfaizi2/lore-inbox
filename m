Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTJPScZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbTJPScS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:32:18 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64006
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263079AbTJPSbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:31:45 -0400
Subject: Re: Transparent compression in the FS
From: Robert Love <rml@tech9.net>
To: John Bradford <john@grabjohn.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org, val@nmt.edu
In-Reply-To: <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk>
References: <1066163449.4286.4.camel@Borogove>
	 <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com>
	 <20031016162926.GF1663@velociraptor.random>
	 <20031016172930.GA5653@work.bitmover.com>
	 <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Message-Id: <1066329102.5398.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Thu, 16 Oct 2003 14:31:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 14:28, John Bradford wrote:

> Surely it's just common sense to say that you have to verify the whole
> block - any algorithm that can compress N values into <N values is
> lossy by definition.  A mathematical proof for that is easy.

That is the problem.

But those pushing this approach argue that the chance of collision is
less than the chance of hardware errors, et cetera.

Read Val's paper.  It is interesting.

	Robert Love


