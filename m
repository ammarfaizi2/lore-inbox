Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVF1HuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVF1HuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVF1Htd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:49:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261939AbVF1Hri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:47:38 -0400
Date: Tue, 28 Jun 2005 00:46:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Cc: stefanr@s5r6.in-berlin.de, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, rbrito@ime.usp.br
Subject: Re: Problems with Firewire and -mm kernels
Message-Id: <20050628004650.18282bd6.akpm@osdl.org>
In-Reply-To: <42C0FF50.7080300@s5r6.in-berlin.de>
References: <20050626040329.3849cf68.akpm@osdl.org>
	<42BE99C3.9080307@trex.wsi.edu.pl>
	<20050627025059.GC10920@ime.usp.br>
	<20050627164540.7ded07fc.akpm@osdl.org>
	<20050628010052.GA3947@ime.usp.br>
	<20050627202226.43ebd761.akpm@osdl.org>
	<42C0FF50.7080300@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>
> >  ieee1394: Node changed: 0-01:1023 -> 0-00:1023
>  >  ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]
> 
>  What caused these two messages? Did you disconnect the drive at this point?

No, there is no device plugged into the machine.

Maybe the G5 has some internal 1394 device?  It would be news to me if so.
