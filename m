Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271112AbTGRHzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271296AbTGRHzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:55:43 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:40670 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S271112AbTGRHzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:55:40 -0400
Date: Fri, 18 Jul 2003 01:10:33 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 954] New: link failure for arch/ppc/mm/built-in.o, function mem_pieces_find
Message-ID: <20030718081033.GE25869@ip68-4-255-84.oc.oc.cox.net>
References: <5310000.1058499045@[10.10.2.4]> <20030718045335.GA12803@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718045335.GA12803@pazke>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 08:53:35AM +0400, Andrey Panin wrote:
> Does this one-line patch helps ?
[snip]

This appears to do the job, yes.

-Barry K. Nathan <barryn@pobox.com>
