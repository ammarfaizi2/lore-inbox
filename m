Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUDUMQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUDUMQT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 08:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUDUMQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 08:16:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36528 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262910AbUDUMQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 08:16:17 -0400
Date: Wed, 21 Apr 2004 13:16:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Sean Neakums <sneakums@zork.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
In-Reply-To: <6ubrllpyr9.fsf@zork.zork.net>
Message-ID: <Pine.LNX.4.44.0404211306170.7738-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Sean Neakums wrote:
> 
> As is this (I assume debugging) message:
> 
> Apr 20 16:20:24 slagpiece kernel: xterm: mremap moved 49 cows
> 
>  ______ 
> < Moo! >
>  ------ 
>         \   ^__^
>          \  (oo)\_______
>             (__)\       )\/\
>                 ||----w |
>                 ||     ||

Lovely!  Thanks for your report, and especially your art - you are the
lucky winner of a huge churn of milk for first report of this message,
just send your details etc. etc.

Yes, more or less a debugging message: nothing bad has happened, just
something rather inefficient, and we'd like to get some idea of how
much it occurs in practice.  xterm, eh?  I wouldn't have guessed that.
Quite a herd.

I hoped a whimsical message might be reported more than a boring one!

Hugh

