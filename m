Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUJWIUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUJWIUo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 04:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUJWIUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 04:20:44 -0400
Received: from ozlabs.org ([203.10.76.45]:13765 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264639AbUJWIUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 04:20:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16762.5205.563634.564951@cargo.ozlabs.ibm.com>
Date: Sat, 23 Oct 2004 18:20:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] xmon sparse cleanups
In-Reply-To: <20041021033617.GK17760@zax>
References: <20041021033617.GK17760@zax>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson writes:

> This patch removes many sparse warnings from the xmon code.  Mostly
> K&R function declarations and 0-instead-of-NULLs.  There are still a
> whole bunch of warnings in xmon/ppc-opc.c, which is a copy of a file
> from binutils.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Paul Mackerras <paulus@samba.org>
