Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267219AbUGNMNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267219AbUGNMNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267269AbUGNMNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:13:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:38351 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267219AbUGNMNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:13:06 -0400
X-Authenticated: #4399952
Date: Wed, 14 Jul 2004 14:20:52 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, paul@linuxaudiosystems.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Bizarre audio behavior
Message-Id: <20040714142052.4b421488@mango.fruits.de>
In-Reply-To: <1089773762.2729.24.camel@mindpipe>
References: <1089773762.2729.24.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004 22:56:03 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> Ok, this is absolutely bizarre.  If I run JACK from a GNOME terminal,
> even with a large period size, all I get are these error messages:
> If I run if from an xterm or a text console, it works perfectly, even 
> with a really small buffer:
> 
> 
> I have no idea where this bug could be, it seems like it would have to be 
> display-related.
> 
> Lee 
> 


Hmm, maybe in one case LD_ASSUME_KERNEL is set?

flo


-- 
Palimm Palimm!
http://affenbande.org/~tapas/wiki

