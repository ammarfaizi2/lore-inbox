Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWAQQ1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWAQQ1Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWAQQ1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:27:16 -0500
Received: from cantor2.suse.de ([195.135.220.15]:11242 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932124AbWAQQ1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:27:15 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 3/4] compact print_symbol() output
Date: Tue, 17 Jan 2006 16:01:52 +0100
User-Agent: KMail/1.8.2
Cc: Akinobu Mita <mita@miraclelinux.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
References: <20060117101555.GD19473@miraclelinux.com> <20060117112318.GA24671@miraclelinux.com> <Pine.LNX.4.61.0601171453270.6403@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0601171453270.6403@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171601.52995.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 16:01, Hugh Dickins wrote:

> I've often found symbolsize useful.  Not when looking at an oops
> from my own machine.  But when looking at an oops posted on LKML,
> from someone who most likely has a different .config and different
> compiler, different optimization and different inlining from mine.
> symbolsize is a good clue as to how close their kernel is to the
> one I've got built on my machine, how likely guesses I make based
> on mine will apply to theirs, and whereabouts in the function that
> it oopsed.

Yes that is why I want it too.

-Andi
