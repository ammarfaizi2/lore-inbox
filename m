Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTH1NDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbTH1NDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:03:39 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:5511 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S264015AbTH1NDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:03:38 -0400
Date: Thu, 28 Aug 2003 14:03:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ragnar Hojland Espinosa <ragnar@linalco.com>
Cc: David Schwartz <davids@webmaster.com>, Timo Sirainen <tss@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828130326.GF6800@mail.jlokier.co.uk>
References: <1062061038.1459.240.camel@hurina> <MDEHLPKNGKAHNMBLJOLKEEJEFLAA.davids@webmaster.com> <20030828124404.GA11988@linalco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828124404.GA11988@linalco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar Hojland Espinosa wrote:
> It can happen.  It happened to me with two gifs.  FWIW.

Probability on the order of 2^-32 with MD5 any-pairs collision.
(It's not usual to have so many GIFs to compare, though :)
SHA is better, and both probably have some weakness that increases the
probability of collision.

Do you still have the GIFs?

-- Jamie
