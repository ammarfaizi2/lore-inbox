Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTGLBQW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 21:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbTGLBQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 21:16:22 -0400
Received: from dp.samba.org ([66.70.73.150]:31956 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263823AbTGLBQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 21:16:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.25800.785348.314274@cargo.ozlabs.ibm.com>
Date: Sat, 12 Jul 2003 11:30:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Samuel Thibault <samuel.thibault@fnac.net>
Cc: linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] [2.5] adding ppp xon/xoff support
In-Reply-To: <20030712011716.GB4694@bouh.unh.edu>
References: <20030712011716.GB4694@bouh.unh.edu>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault writes:

> This patch wasn't applied, probably because the misplaced else
> statement, here is a corrected version. This would at last make linux
> support xon/xoff for ppp connections (it hasn't been available since 2.0
> at least).
> 
> Please apply,

Have you tested it?  If so, how?

Thanks,
Paul.
