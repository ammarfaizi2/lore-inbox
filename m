Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270490AbTHCF1h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 01:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270520AbTHCF1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 01:27:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:11431 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270490AbTHCF1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 01:27:35 -0400
Date: Sat, 2 Aug 2003 22:28:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm3
Message-Id: <20030802222839.1904a247.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0308030106380.3473@montezuma.mastecende.com>
References: <20030802152202.7d5a6ad1.akpm@osdl.org>
	<Pine.LNX.4.53.0308030106380.3473@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> On Sat, 2 Aug 2003, Andrew Morton wrote:
> 
> > . I don't think anyone has reported on whether 2.6.0-test2-mm2 fixed any
> >   PS/2 or synaptics problems.  You are all very bad.
> 
> It works now by disabling CONFIG_MOUSE_PS2_SYNAPTICS
> 

err, that's a bug isn't it?
