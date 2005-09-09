Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVIIIwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVIIIwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVIIIwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:52:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:25528 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965099AbVIIIwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:52:08 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] set stack pointer in init_tss and init_thread
Date: Fri, 9 Sep 2005 10:52:03 +0200
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43207DB6020000780002453F@emea1-mh.id2.novell.com>
In-Reply-To: <43207DB6020000780002453F@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091052.04225.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:06, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
>
> Set the stack pointer correctly in init_thread and init_tss.

Thanks applied.

-Andi
