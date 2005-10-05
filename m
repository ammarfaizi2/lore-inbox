Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbVJEPaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbVJEPaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbVJEPaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:30:10 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:31129 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965224AbVJEPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:30:08 -0400
Date: Wed, 5 Oct 2005 11:30:06 -0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Marc Perkel <marc@perkel.com>, Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005153006.GD8011@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005152447.GD10538@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005152447.GD10538@lkcl.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 04:24:47PM +0100, Luke Kenneth Casson Leighton wrote:
>   ahh, *sigh*, i remember the days.
> 
>   in 1989 i looked in /tmp on our sunos 4.1.3 server at
>   imperial, which was running a bit slow, went "eek, that's
>   a lot of files in /tmp" and did am rm -fr /tmp.

Why would /tmp allow you to delete files there you didn't own unless you
were root?  Why would someone with root blindly delete things they
didn't know what were?

>   a few minutes later the sysadmins quite literally stormed in.

And promptly removed root access from the person that wasn't qualified
to have it in the first place? :)

>   apparently the printer queue temp files were stored in /tmp and 100
>   third year students were all trying to print out their course-work,
>   last minute.
> 
And why would the printer queue use /tmp in the first place?

>   oops.
> 
>   yes, imperial college third year theory of computing students of
>   1987-1990, it was me.

Did they ever let you have root again?

Len Sorensen
