Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275482AbTHJJI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275484AbTHJJI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:08:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:3504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275482AbTHJJIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:08:50 -0400
Date: Sun, 10 Aug 2003 02:08:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1
Message-Id: <20030810020848.3b9484d4.akpm@osdl.org>
In-Reply-To: <1060506097.5242.4.camel@sunshine>
References: <20030809203943.3b925a0e.akpm@osdl.org>
	<1060506097.5242.4.camel@sunshine>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor MICSKO <gmicsko@szintezis.hu> wrote:
>
> drivers/media/video/videodev.c:398: error: `video_proc_entry' undeclared
>  here (not in a function)

Just delete that line.
