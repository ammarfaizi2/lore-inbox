Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVHDC21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVHDC21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 22:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVHDC21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 22:28:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261744AbVHDC20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 22:28:26 -0400
Date: Wed, 3 Aug 2005 19:27:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Message-Id: <20050803192707.2ff80381.akpm@osdl.org>
In-Reply-To: <1123069109.30257.23.camel@gaston>
References: <1122908972.18835.153.camel@gaston>
	<20050802095312.GA1442@elf.ucw.cz>
	<1123069109.30257.23.camel@gaston>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Andrew, please back that off before 2.6.13. I'll try to send a patch if
>  you want later today if I find some time with a kernel source at hand.

Please do.
