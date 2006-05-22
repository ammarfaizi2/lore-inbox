Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWEYOd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWEYOd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWEYOd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:33:56 -0400
Received: from fmr20.intel.com ([134.134.136.19]:19098 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030189AbWEYOd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:33:56 -0400
Date: Mon, 22 May 2006 14:08:13 -0700
From: mark gross <mgross@linux.intel.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6]  EDAC maintainers update
Message-ID: <20060522210813.GA9816@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20060524174957.25600.qmail@web50106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524174957.25600.qmail@web50106.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 10:49:57AM -0700, Doug Thompson wrote:
> 
> Removed Dave Peterson as per his request as co-maintainer of EDAC
> Thanks for the work Dave.
> 
> Signed-of-by: Doug Thompson <norsk5@xmission.com>
> 
> 
> Index: linux-2.6.17-rc4/MAINTAINERS
> ===================================================================
> --- linux-2.6.17-rc4.orig/MAINTAINERS	2006-05-23 10:40:04.000000000 -0600
> +++ linux-2.6.17-rc4/MAINTAINERS	2006-05-24 11:02:07.000000000 -0600
> @@ -892,23 +892,21 @@
>  
>  EDAC-CORE
>  P:	Doug Thompson
> -M:	norsk5@xmission.com, dthompson@linuxnetworx.com
> -P:	Dave Peterson
> -M:	dsp@llnl.gov, dave_peterson@pobox.com
> +M:	norsk5@xmission.com
>  L:	bluesmoke-devel@lists.sourceforge.net
>  W:	bluesmoke.sourceforge.net
> -S:	Maintained
> +S:	Supported
>  
>  EDAC-E752X
> -P:	Dave Peterson
> -M:	dsp@llnl.gov, dave_peterson@pobox.com
> +P:	Mark Gross
> +M:	mark.gross@intel.com
>  L:	bluesmoke-devel@lists.sourceforge.net
>  W:	bluesmoke.sourceforge.net
>  S:	Maintained

Ack.

--mgross

