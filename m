Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVCQVsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVCQVsp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCQVq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:46:57 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:58884 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261220AbVCQVpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:45:32 -0500
Date: Thu, 17 Mar 2005 21:44:19 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, yuasa@hh.iij4u.or.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][resend] convert a remaining verify_area to access_ok (was: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok) (fwd)
Message-ID: <20050317214419.GB14882@linux-mips.org>
References: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost> <20050316145524.18787569.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316145524.18787569.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 02:55:24PM -0800, Andrew Morton wrote:

> That's tricky stuff you're playing with, so I'd prefer it came in via Ralf.
> However I can queue it up locally so it doesn't get forgotten.

Did look good except I recently turned uaccess.h upside down for the
sake of sparse.

  Ralf
