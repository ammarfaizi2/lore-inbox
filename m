Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUAIBOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266392AbUAIBOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:14:19 -0500
Received: from [130.57.169.10] ([130.57.169.10]:47240 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S266391AbUAIBOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:14:18 -0500
Subject: Re: 2.6.1-rc2-mm1
From: Robert Love <rml@ximian.com>
To: Roberto Sanchez <rcsanchez97@yahoo.es>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <3FFDFEB3.3010301@yahoo.es>
References: <20040107232831.13261f76.akpm@osdl.org>
	 <1073593346.1618.3.camel@moria.arnor.net>
	 <1073594795.1738.2.camel@moria.arnor.net>  <3FFDFEB3.3010301@yahoo.es>
Content-Type: text/plain
Message-Id: <1073610855.1228.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 08 Jan 2004 20:14:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 20:06, Roberto Sanchez wrote:

> I get hard lockups during boot up, in X, and when starting big apps
> (mozilla, OOo, Neverwinter Nights, etc).  I reverted to -rc1-mm1.

There is a nasty bug in the poll code, I think.

	Robert Love


