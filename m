Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVJLL7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVJLL7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 07:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJLL7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 07:59:45 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:18332 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932429AbVJLL7o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 07:59:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rRwg/Vm8kwUkp4gXawKhDxCCEU+DQXbDnjOX0agLsuR/G1YG7iA7+FUeUPhbdrKbzHqlBk91+++wQ9ZxcxBCdZnKWNfcXIE0q6J6ZmBIUgPxqLAfNWTOTBBweZOgGsT6+ROen41QTyafwMFffE3Fm46LyGgxNF/AwjL9QbdGsLc=
Message-ID: <84144f020510120459n36934859ic1d0d56e8a33c593@mail.gmail.com>
Date: Wed, 12 Oct 2005 14:59:43 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: [PATCH] hpfs: Whitespace and Codingstyle cleanup for dir.c
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0510121327580.28884@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510121326.52216.jesper.juhl@gmail.com>
	 <Pine.LNX.4.62.0510121327580.28884@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 10/12/05, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
> I don't see anything wrong with
>         if (some_condition) do_some_action();
> statements. Generally, if they consume less lines, you can see more code
> on a screen.

>From Documentation/CodingStyle:

"Don't put multiple statements on a single line unless you have
something to hide:"

                                Pekka
