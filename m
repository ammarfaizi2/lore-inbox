Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTFKHZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 03:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTFKHZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 03:25:54 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:8411 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP id S264190AbTFKHZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 03:25:53 -0400
Date: Wed, 11 Jun 2003 03:39:34 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse type checking on function pointers
Message-ID: <20030611073934.GA1733@arizona.localdomain>
References: <20030610230318.GA10106@osdl.org> <Pine.LNX.4.44.0306101604150.2044-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306101604150.2044-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [141.149.48.53] at Wed, 11 Jun 2003 02:39:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 04:06:46PM -0700, Linus Torvalds wrote:
>So I'm
> checking in a "make install" target for sparse, and I'll make the default
> CHECK binary be "sparse".

Hi Linus,

The name "sparse" is very difficult to google for because it's a common
English word.  It can also make comments and emails confusing when one
doesn't immediately know which meaning of "sparse" is being used.  Perhaps
a name like "s-parse" would be more appropriate.

-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
