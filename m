Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261909AbSJIRxp>; Wed, 9 Oct 2002 13:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbSJIRxo>; Wed, 9 Oct 2002 13:53:44 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:43945 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261909AbSJIRxb>; Wed, 9 Oct 2002 13:53:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2.5.41] trap in __release_resource
Date: Wed, 9 Oct 2002 12:56:07 -0500
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200210091719.g99HJBVM001363@kleikamp.austin.ibm.com> <20021009185405.B23671@flint.arm.linux.org.uk>
In-Reply-To: <20021009185405.B23671@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210091256.07793.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 12:54, Russell King wrote:
>
> Oddly, I've also sent this patch out in the last couple of days. 8)
> Its correct.

Okay, I found it now.  It was the second part of a patch that fixed 
another problem.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

