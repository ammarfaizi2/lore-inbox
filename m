Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVGGMIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVGGMIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVGGMFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:05:19 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:6303 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261282AbVGGMEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:04:30 -0400
To: ncunningham@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
In-Reply-To: <1120696047.4860.525.camel@localhost>
References: <11206164393426@foobar.com> <20050706082230.GF1412@elf.ucw.cz> <20050706082230.GF1412@elf.ucw.cz> <1120696047.4860.525.camel@localhost>
Date: Thu, 7 Jul 2005 13:04:30 +0100
Message-Id: <E1DqV7G-0004PX-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:

> I've been thinking about this some more and wondering whether I should
> just replace swsusp. I really don't want to step on your toes though.
> What would you like to see happen?

Do you implement the entire swsusp userspace interface? If not, removing
it probably isn't a reasonable plan without fair warning.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
