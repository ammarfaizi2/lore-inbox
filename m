Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWAJGiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWAJGiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWAJGiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:38:12 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:24598 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932076AbWAJGiK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:38:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lnVgYZ52hxhgH2ZrKRq3Xtkw4GNh/mfc39/L/K1ViQ0gCa7+cATWFdVSXsLdbVrh15au2zMUN/ylfhfLAQJBUDJ5ldJnC+4nE2SyrXxnkok7NvUrztJz2ITYdGmUKUPIAv2SSUvF60MxBDLdOyrU3xIYGQWXnvpOvRNPUteyrr4=
Message-ID: <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
Date: Tue, 10 Jan 2006 19:38:07 +1300
From: Martin Langhoff <martin.langhoff@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: git pull on Linux/ACPI release tree
Cc: Luben Tuikov <ltuikov@yahoo.com>, "Brown, Len" <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
       Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org>
	 <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> If they all work, then we know precisely that it's the
> interactions between them, which also makes debugging a lot easier.

The more complex your tree structure is, the more the interactions are
likely to be part of the problem. Is git-bisect not useful in this
scenario?

cheers,


martin
