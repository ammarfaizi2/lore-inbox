Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVBYBXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVBYBXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 20:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVBYBXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 20:23:33 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:25530 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262345AbVBYBX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 20:23:29 -0500
Date: Fri, 25 Feb 2005 02:23:26 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1 strange messages
Message-ID: <20050225012326.GA14302@gamma.logic.tuwien.ac.at>
References: <20050125121704.GA22610@gamma.logic.tuwien.ac.at> <20050125102834.7e549322.akpm@osdl.org> <20050224141015.GA6756@gamma.logic.tuwien.ac.at> <20050224150326.3a82986c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050224150326.3a82986c.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Don, 24 Feb 2005, Andrew Morton wrote:
> What does the stack backtrace from iounmap-debugging.patch say?

iounmap: bad address c00fffd9
 [<c03f8430>] trap_init+0x30/0x190
 [<c03f2697>] start_kernel+0x47/0x1c0


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
"What was the self-sacrifice?"
"I jettisoned half of a much loved and I think
irreplaceable pair of shoes."
"Why was that self-sacrifice?"
"Because they were mine!" said Ford crossly.
"I think we have different value systems."
"Well mine's better."
"That's according to your... oh never mind."
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
