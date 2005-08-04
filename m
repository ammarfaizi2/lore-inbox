Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVHDWjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVHDWjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbVHDWjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:39:18 -0400
Received: from ozlabs.org ([203.10.76.45]:32688 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262767AbVHDWjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:39:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17138.38287.648439.271259@cargo.ozlabs.ibm.com>
Date: Fri, 5 Aug 2005 08:24:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: youssef@ece.utexas.edu
Cc: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH][PPP] ppp_generic: Add checks for NULL pointers
In-Reply-To: <Pine.LNX.4.61.0508040053050.14176@linux08.ece.utexas.edu>
References: <Pine.LNX.4.61.0508040053050.14176@linux08.ece.utexas.edu>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmamouche, Youssef writes:

> This patch adds two checks for NULL pointers.

OK, but get the whitespace right please - use tabs not spaces for
indentation, and put a space between "if" and "(".  See
Documentation/CodingStyle.

Paul.
