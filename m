Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265265AbUENNAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUENNAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbUENNAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:00:39 -0400
Received: from village.ehouse.ru ([193.111.92.18]:8208 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S265265AbUENNAi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:00:38 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] befs (1/5): LBD support
Date: Fri, 14 May 2004 17:00:30 +0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, will_dyson@pobox.com
References: <200405132232.09816.rathamahata@php4.ru> <20040513191633.3d0f3492.akpm@osdl.org>
In-Reply-To: <20040513191633.3d0f3492.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405141700.30606.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 May 2004 06:16, Andrew Morton wrote:
> "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> >
> > fs/befs/linuxvfs.c
> 
> Wow, BeFS maintenance.
> 
> Are you regularly testing BeFS?  If so, do you think it still deserves to
> be labelled "experimental"?

Yes, I'm trying to test BeFS regularly.
>From my experience the current read only driver is fairly stable.

> 

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
