Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTJ2TOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTJ2TOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:14:15 -0500
Received: from multiserv.relex.ru ([213.24.247.63]:36017 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S261344AbTJ2TOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:14:14 -0500
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI && vortex still broken in latest 2.4 and 2.6.0-test9
Date: Wed, 29 Oct 2003 23:14:14 +0300
User-Agent: KMail/1.5.4
References: <20031029134848.GA949@hello-penguin.com> <200310291832.22650.yarick@relex.ru> <20031029184758.GA1201@hello-penguin.com>
In-Reply-To: <20031029184758.GA1201@hello-penguin.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310292314.14227.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
> > Yes. With IBM's DSDT, to be more specific. I've filed a bug in the
> > bugzilla,
>
> Well, I could try a Dell BIOS on my A21p if buying a SCO-Linux license
Don't do it - you will damage your 'book and void the warranty.
>
> Maybe this is interesting: It's a diff of lspci -vvvvvvvvv
> without and with acpi enabled...
lspci -H1 -vv -xxx gives more results. 
My dumps are at 
http://www.relex.ru/~yarick/acpi
Bug number at bugme.osdl.org is 1188

-- 
With all the best, yarick at relex dot ru.

