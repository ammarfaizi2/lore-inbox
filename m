Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269976AbUICXXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269976AbUICXXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269979AbUICXXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:23:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:30372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269976AbUICXXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:23:48 -0400
Date: Fri, 3 Sep 2004 16:27:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: yuvalt@gmail.com
Cc: yuval@il.aduva.com, sam@ravnborg.org, zippel@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Menuconfig search changes
Message-Id: <20040903162718.659107d4.akpm@osdl.org>
In-Reply-To: <4136EB54.6060705@il.aduva.com>
References: <4136EB54.6060705@il.aduva.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuval Turgeman <yuval@il.aduva.com> wrote:
>
> Modified the search to go over the properties attached to a symbol (like 
> Roman suggessted).
> Added regex support to help narrow down the searches.
> Displaying the parameter's dependencies (nothing fency - simply using 
> expr_fprint).
> Added a 'show_file' helper function.

Your patch was wordwrapped by your email client and I couldn't get it
to apply after fixing that up.

Please send a new patch against 2.6.9-rc1-mm3, retaining the changelog
details.   See http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Thanks.
