Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUHaRPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUHaRPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUHaRME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:12:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2205 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264953AbUHaRLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:11:25 -0400
Message-ID: <4134B12B.5070805@pobox.com>
Date: Tue, 31 Aug 2004 13:11:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [DOC] Linux kernel patch submission format
References: <413431F5.9000704@pobox.com> <20040831170752.GC7310@mars.ravnborg.org>
In-Reply-To: <20040831170752.GC7310@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Suggested:
> [PATCH $version $n/$total] one-line summary
> 
> Preferable:
> [PATCH $version $n/$total] subsystem: one-line summary


The text says that subsystem is included in the one-line summary, but 
you're right...  I'll make it more clear.  Updated.

	Jeff


