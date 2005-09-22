Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVIVXj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVIVXj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 19:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVIVXj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 19:39:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751208AbVIVXj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 19:39:27 -0400
Date: Thu, 22 Sep 2005 16:39:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ide problems ?
Message-Id: <20050922163930.45727d3d.akpm@osdl.org>
In-Reply-To: <1127428133.17227.94.camel@dyn9047017102.beaverton.ibm.com>
References: <20050921222839.76c53ba1.akpm@osdl.org>
	<64900000.1127415577@[10.10.2.4]>
	<20050922125219.7ea04930.akpm@osdl.org>
	<1127428133.17227.94.camel@dyn9047017102.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@gmail.com> wrote:
>
> My ide-based AMD64 machine doesn't boot 2.6.14-rc2-mm1.
> Known issue ?

Nope.   How does that dmesg output differ from 2.6.14-rc2's?
