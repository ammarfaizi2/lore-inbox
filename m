Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTLRHLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 02:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTLRHLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 02:11:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28114 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261775AbTLRHLx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 02:11:53 -0500
Message-ID: <3FE1532A.2010109@pobox.com>
Date: Thu, 18 Dec 2003 02:11:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Joe Pranevich <jpranevich@kniggit.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com
Subject: Re: Wonderful World of Linux 2.6 - Final
References: <3FE13D07.6080204@cyberone.com.au>
In-Reply-To: <3FE13D07.6080204@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> I'll just mention that the "Hyperthreading" section is not entirely
> accurate: the process scheduler is blissfully unaware of HT / SMT
> presently. It is a must fix item though, and there are a number of
> different implementations available to solve this.


Are you sure?  I could have sworn Ingo made the scheduler magically 
HT-friendly...

	Jeff



