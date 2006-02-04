Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946195AbWBDAqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946195AbWBDAqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946196AbWBDAqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:46:48 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:24971 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946195AbWBDAqr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:46:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l6K1SoDk18ZtS1XO01dpSoV6IFaVgYN/NdYu2MytSVIwzRltg8AJxH9zdxgnk04lr0nnsrHssIvlEi59La/qqW4IIvrx41VGVKNUL3Px2VvpQ08Oup3+26OLtVyh7dw8fd2U4+Ot3BTeaBKdfshgOJMRH5TPBM3RPJvYjhNgjgs=
Message-ID: <986ed62e0602031646x5aea624bn8688f466bd1ff3ab@mail.gmail.com>
Date: Fri, 3 Feb 2006 16:46:46 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Cc: Pavel Machek <pavel@ucw.cz>, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060202132708.62881af6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602022131.59928.nigel@suspend2.net>
	 <20060202115907.GH1884@elf.ucw.cz>
	 <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz>
	 <20060202132708.62881af6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Andrew Morton <akpm@osdl.org> wrote:
> Random thoughts:
>
> - swsusp has been a multi-year ongoing source of churn and bug reports.
>   It hasn't been a big success and we have a way to go yet.

swsusp may be an ongoing source of churn and bug reports, but it's
also been more reliable for me (on multiple types of hardware) than
Windows XP hibernate. In fact, at this point I'm perfectly satisfied
with its reliability (i.e. I haven't had any problems lately).

(I just figure that I need to speak up, as a highly satisfied swsusp user.)
--
-Barry K. Nathan <barryn@pobox.com>
