Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUEFPLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUEFPLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUEFPLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:11:35 -0400
Received: from smtp-out3.xs4all.nl ([194.109.24.13]:15621 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S262488AbUEFPLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:11:31 -0400
Date: Thu, 6 May 2004 17:11:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv.local
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: akpm@osdl.org, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] report size of printk buffer
In-Reply-To: <20040506133639.GB14714@apps.cwi.nl>
Message-ID: <Pine.LNX.4.44.0405061708170.765-100000@serv.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 May 2004, Andries Brouwer wrote:

> If one asks for count bytes, one gets the last count bytes of output,
> not the first.

That doesn't answer the question, why don't you just clear the data that
was read?

bye, Roman

