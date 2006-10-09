Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWJIMp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWJIMp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWJIMp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:45:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:17605 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751866AbWJIMp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:45:28 -0400
Subject: Re: [PATCH] ARCH=ppc pt_regs fixes
From: Josh Boyer <jdub@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061009114842.GO29920@ftp.linux.org.uk>
References: <20061009114842.GO29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 07:49:06 -0500
Message-Id: <1160398146.5626.1.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 12:48 +0100, Al Viro wrote:
>  arch/ppc/syslib/ppc4xx_pic.c        |    8 ++++----

I already sent a patch for this file and I was working on some of the
other 4xx stuff.  But overall yours is much more comprehensive.

Ack-by: Josh Boyer <jdub@us.ibm.com>

josh

