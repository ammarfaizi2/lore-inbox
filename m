Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTKSFph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 00:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTKSFph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 00:45:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:33934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263861AbTKSFpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 00:45:36 -0500
Date: Tue, 18 Nov 2003 21:45:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: jon@jon-foster.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
Message-Id: <20031118214515.425dbe26.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0311182220570.11537@montezuma.fsmlabs.com>
References: <3FBAAFDF.5000803@jon-foster.co.uk>
	<Pine.LNX.4.53.0311182220570.11537@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
>  I've walked that code and can't see anything wrong anywhere.

fwiw, X comes up happily on a couple of boxes here, with the 4g/4g split
enabled.

Have you tried a different compiler?

