Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbVJEPZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVJEPZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVJEPZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:25:04 -0400
Received: from free.hands.com ([83.142.228.128]:31660 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S965214AbVJEPZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:25:01 -0400
Date: Wed, 5 Oct 2005 16:24:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Marc Perkel <marc@perkel.com>
Cc: Nix <nix@esperi.org.uk>, 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005152447.GD10538@lkcl.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343E611.1000901@perkel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 07:41:21AM -0700, Marc Perkel wrote:
> If you were going to do it right here's what you would do:
> 
> People who had files in /tmp would have no rights at all to other users 
> /tmp files.
> Listing the dirtectory would only display the files you had some access 
> to. If you have no rights you don't even see that the file is there.
> The effect would be like giving people their own tmp directories.
 
  ahh, *sigh*, i remember the days.

  in 1989 i looked in /tmp on our sunos 4.1.3 server at
  imperial, which was running a bit slow, went "eek, that's
  a lot of files in /tmp" and did am rm -fr /tmp.

  a few minutes later the sysadmins quite literally stormed in.

  apparently the printer queue temp files were stored in /tmp and 100
  third year students were all trying to print out their course-work,
  last minute.

  oops.

  yes, imperial college third year theory of computing students of
  1987-1990, it was me.

  l.

