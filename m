Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVHZSwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVHZSwS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVHZSwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:52:18 -0400
Received: from peabody.ximian.com ([130.57.169.10]:12734 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030186AbVHZSwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:52:17 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Robert Love <rml@novell.com>
To: Dave Jones <davej@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Brian Gerst <bgerst@didntduck.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050826184520.GE20541@redhat.com>
References: <1125069494.18155.27.camel@betsy>
	 <430F5257.4010700@didntduck.org> <1125077594.18155.52.camel@betsy>
	 <1125079311.4294.10.camel@laptopd505.fenrus.org>
	 <1125079430.18155.64.camel@betsy>  <20050826184520.GE20541@redhat.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 14:52:15 -0400
Message-Id: <1125082335.18155.81.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 14:45 -0400, Dave Jones wrote:

> A little difficult for people to submit dmi patches, unless they
> have hardware this driver runs on.   Surely as you've tested this,
> you're in the best position to write such patches :-)

Surely one of the millions of people with a ThinkPad can feel free to
try a DMI-based probe() out, if they want a probe() routine, was my
point.

	Robert Love


