Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWFKXko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWFKXko (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 19:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWFKXko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 19:40:44 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:425 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751157AbWFKXkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 19:40:43 -0400
Subject: Re: [PATCH] x86 built-in command line
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20060611215530.GH24227@waste.org>
References: <20060611215530.GH24227@waste.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 01:40:41 +0200
Message-Id: <1150069241.3131.97.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 16:55 -0500, Matt Mackall wrote:
> This patch allows building in a kernel command line on x86 as is
> possible on several other arches.


wouldn't it make more sense to allow the initramfs to set such arguments
instead?


