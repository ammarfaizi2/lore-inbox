Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWGLFfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWGLFfG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWGLFfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:35:05 -0400
Received: from mail.gmx.net ([213.165.64.21]:26335 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751168AbWGLFfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:35:04 -0400
X-Authenticated: #14349625
Subject: Re: Runnable threads on run queue
From: Mike Galbraith <efault@gmx.de>
To: Ask List <askthelist@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20060712T060407-876@post.gmane.org>
References: <loom.20060708T220409-206@post.gmane.org>
	 <1152429626.9711.34.camel@Homer.TheSimpsons.net>
	 <loom.20060712T060407-876@post.gmane.org>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 07:40:56 +0200
Message-Id: <1152682856.9689.16.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 04:14 +0000, Ask List wrote:
> Network Problem? So your saying our mail servers are not sending spam traffic
> fast enough if spam assassin processes are running out of work to do? So when
> our mail servers are not sending spam traffic we see our cpu,cs,interrupts, &
> runnable threads drop ...?

More or less, yes.  I think somebody is dropping the communication ball.

	-Mike

