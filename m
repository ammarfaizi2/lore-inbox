Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbUKKOiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbUKKOiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 09:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbUKKOiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 09:38:23 -0500
Received: from vena.lwn.net ([206.168.112.25]:45993 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262241AbUKKOiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 09:38:22 -0500
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SECURITY] iSEC advisory about binfmt_elf 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Thu, 11 Nov 2004 14:36:00 +0100."
             <20041111133600.GA9696@alpha.home.local> 
Date: Thu, 11 Nov 2004 07:37:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S262239AbUKKOiX/20041111143823Z+32@vger.kernel.org>

> has anyone already looked at this ? This advisory comes from the following
> location :
> 
>      http://isec.pl/vulnerabilities/isec-0017-binfmt_elf.txt

For 2.6, anyway:

	http://lwn.net/Articles/110487/

Patch by Chris Wright.

jon
