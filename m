Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTDPCCx (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 22:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbTDPCCx 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 22:02:53 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:58305 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264199AbTDPCCw 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 22:02:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [2.4.20-ck6] Rmap15f patch fails in vmscan.c
Date: Wed, 16 Apr 2003 12:16:24 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030416013942.GA31943@triplehelix.org>
In-Reply-To: <20030416013942.GA31943@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304161216.25010.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003 11:39, Joshua Kwan wrote:
> The subject says it all. Extracted a clean 2.4.20 tree, patched it with
> the full -ck6 patch, then applied the rmap15f patch, and it fails in
> mm/vmscan.c. Give it a try for yourself... :)
>
> (The reason why I haven't just fixed it myself is because the rejects
> file is really big, and it seems to me like something you can easily
> correct with your sources, by rediffing against the right version of the
> file or something.)

Woops my bad. Will fix asap.

Con
