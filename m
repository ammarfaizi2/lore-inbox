Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVJIAub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVJIAub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 20:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVJIAub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 20:50:31 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:51217 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932195AbVJIAua convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 20:50:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iu67WZOyhfoQA7pAQwyLtctLPl/YmHi66iUq1BhSrSRknvrPwclhB6+dbfH7ms26J/H61FuHeHg/aVqrMMeHb8jpC8LVe0St9ZxN8yTsr1F110wbYL4NpFMffxPSJDxmtEWpq2Jods6cHKJbEvp/Tg3BHyGhbkmvwCHkREgymZI=
Message-ID: <2cd57c900510081750s4512a592oacd651b79f90b9b3@mail.gmail.com>
Date: Sun, 9 Oct 2005 08:50:29 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: com bio <combiofriends@yahoo.com>
Subject: Re: problem with SU
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051008200301.47923.qmail@web32812.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051008200301.47923.qmail@web32812.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/05, com bio <combiofriends@yahoo.com> wrote:
> Hello,
>  I have a strange problem with the su command. When i
> issue a su command i get the error
>
> "setgid: operation not permitted "
>
> I get this error in a machine that runs both fedora
> and debian. Its a dual boot system. The error is from
> debian sarge. I had disabled selinux in fedora. I dont
> know if that would be problem with debian. I wonder if
> debian has selinux. If someone can help, Then thanks

run this to see if your debian has selinux

  dpkg -l selinux
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
