Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWHOBWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWHOBWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 21:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWHOBWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 21:22:15 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:2968 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932213AbWHOBWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 21:22:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ED21su+MBCjTGUNt8Ly1DDK/m6vXMJPCrmG9AKm3JrzsrpwhqCB5bS6bDqJXAoaIU3wjKrZ1DUVBPE4UFokaql0G7oq3iCxf3XY0y2nRxDRSXZDV0nVQOZdF6ydJAMahWYY8S5fnKdDBZYeAHssbunfMSjEsWld26C0JScwbYj8=
Subject: Re: vga text console
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: James C Georgas <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155604313.8131.4.camel@Rainsong>
References: <1155604313.8131.4.camel@Rainsong>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 09:22:08 +0800
Message-Id: <1155604928.3948.8.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 21:11 -0400, James C Georgas wrote:
> I can't seem to remove the VGA text console from my kernel
> configuration. Can someone please enlighten me?

You can't. It is always part of the kernel (for X86 at least). What's
your intention?

Tony


