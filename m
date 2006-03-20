Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWCTNt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWCTNt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWCTNt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:49:26 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22461 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932301AbWCTNtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:49:25 -0500
Date: Mon, 20 Mar 2006 19:19:20 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux POSIX AIO V0.8 released
Message-ID: <20060320134920.GA619@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1142861629.4668.8.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1142861629.4668.8.camel@frecb000686>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just cc'ing lkml on your post as well.

Regards
Suparna

On Mon, Mar 20, 2006 at 02:33:49PM +0100, Sébastien Dugué wrote:
> The Linux POSIX AIO V0.8 library has been released:
> 
>   it is available at http://www.bullopensource.org/posix.
> 
>   Major changes are :
> 
>   - x86_64 implementation fixed (needs some more testing)
>   - Fixed testcases use of volatile variables
> 
>   Hopefully, the x86_64 fixes apply as well to the ia64 implementation.
> Testers are welcome for this architecture.
> 
>   As always, comments are welcome.
> 
>   Sébastien.
> 
> -- 
> -----------------------------------------------------
> 
>   Sébastien Dugué                BULL/FREC:B1-247
>   phone: (+33) 476 29 77 70      Bullcom: 229-7770
> 
>   mailto:sebastien.dugue@bull.net
> 
>   Linux POSIX AIO: http://www.bullopensource.org/posix
>                    http://sourceforge.net/projects/paiol
> 
> -----------------------------------------------------
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

