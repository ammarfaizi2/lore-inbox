Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312427AbSDCWea>; Wed, 3 Apr 2002 17:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312428AbSDCWeV>; Wed, 3 Apr 2002 17:34:21 -0500
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:21616 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S312427AbSDCWeP>; Wed, 3 Apr 2002 17:34:15 -0500
Date: Wed, 3 Apr 2002 23:33:52 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Gerd Knorr <kraxel@bytesex.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.44L.0204031922570.18660-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0204032327360.2006-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Rik van Riel wrote:
> after all Redhat, SuSE, Conectiva, etc. wouldn't want to have
> vmware and Veritas use their work without giving anything back ...
>

Rik,

I don't know about vmware (probably applies too) but more than one person
at Veritas can be justly offended by your implication that Veritas
employees have not contributed anything useful to the Linux kernel.

I hope I understood you incorrectly and you weren't implying anything of
the kind.

In fact, the very existence of any "issue" here is due to the fundamental
impossibility to "measure" such contributions by inventing some
constraints on exporting symbols to modules.

Regards,
Tigran


