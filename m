Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTIBSNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbTIBSLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:11:31 -0400
Received: from rubicon.hasler.ascom.ch ([139.79.129.1]:34964 "EHLO
	rubicon.hasler.ascom.ch") by vger.kernel.org with ESMTP
	id S264043AbTIBSI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:08:57 -0400
Date: Tue, 2 Sep 2003 20:08:03 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
To: Christoph Hellwig <hch@infradead.org>, Andrew Lunn <andrew@lunn.ch>,
       linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-ID: <20030902180803.GA6652@biferten.ma.tech.ascom.ch>
References: <20030902104212.GA23978@londo.lunn.ch> <20030902150808.A7388@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902150808.A7388@infradead.org>
User-Agent: Mutt/1.4i
X-Filter-Version: 1.11a (rubicon)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, that's why we have UNIX98 ptys.  My preferred fix for this
> issue would be to just axe traditional ptys, although this would probably
> make it us incompatible with libc5.
> 
> Why aren't you using the new-style ptys?

Ripperx, the program that is failing, is not mine. I have no control
over what sort of pty it uses. Im sure there are other programs with
use traditional pty's as well.

    Andrew

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
> Well, that's why we have UNIX98 ptys.  My preferred fix for this
> issue would be to just axe traditional ptys, although this would probably
> make it us incompatible with libc5.
> 
> Why aren't you using the new-style ptys?

Ripperx, the program that is failing, is not mine. I have no control
over what sort of pty it uses. Im sure there are other programs with
use traditional pty's as well.

    Andrew

