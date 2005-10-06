Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVJFPyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVJFPyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVJFPyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:54:17 -0400
Received: from main.gmane.org ([80.91.229.2]:27618 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751113AbVJFPyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:54:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH] Documentation: ksymoops should no longer be used to decode
 Oops messages
Date: Fri, 07 Oct 2005 00:49:48 +0900
Message-ID: <di3h5d$f82$1@sea.gmane.org>
References: <200510052239.43492.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050913)
X-Accept-Language: en-us, en
In-Reply-To: <200510052239.43492.jesper.juhl@gmail.com>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Document the fact that ksymoops should no longer be used to decode Oops
> messages.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  Documentation/Changes |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.14-rc3-git5-orig/Documentation/Changes	2005-10-03 21:54:50.000000000 +0200
> +++ linux-2.6.14-rc3-git5/Documentation/Changes	2005-10-05 22:35:44.000000000 +0200
> @@ -31,7 +31,7 @@
>  Eine deutsche Version dieser Datei finden Sie unter
>  <http://www.stefan-winter.de/Changes-2.4.0.txt>.
>  
> -Last updated: October 29th, 2002
> +Last updated: October 05th, 2005
>  
>  Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
>  
> @@ -139,9 +139,8 @@
>  Ksymoops
>  --------
>  
> -If the unthinkable happens and your kernel oopses, you'll need a 2.4
> -version of ksymoops to decode the report; see REPORTING-BUGS in the
> -root of the Linux source for more information.
> +With a 2.4 kernel you need ksymoops to decode a kernel Oops message. With
> +2.6 kernels ksymoops is no longer needed and should not be used.
>  
>  Module-Init-Tools
>  -----------------

OK, but what should I use then with 2.6??
And since when is ksymoops not usable with it?
I have reported quite a few times here, alaways with 2.6.x and nobody said anything about it...

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

