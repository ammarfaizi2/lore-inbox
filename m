Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVGLXy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVGLXy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVGLXwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:52:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56729 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262470AbVGLXvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:51:07 -0400
Subject: Re: realtime-preempt + reiser4?
From: Lee Revell <rlrevell@joe-job.com>
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D45438.6040409@gmail.com>
References: <42D4201A.9050303@gmail.com>
	 <1121198723.10580.10.camel@mindpipe>  <42D45438.6040409@gmail.com>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 19:51:05 -0400
Message-Id: <1121212265.26266.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 19:37 -0400, Keenan Pepper wrote:
> but I'm not sure if that's right. I guess I'll see when I try to boot it!
> 

The standard fix is to make it a compat_semaphore.  See the list
archives for details.

Lee

