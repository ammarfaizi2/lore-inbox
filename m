Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVEWO6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVEWO6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEWO6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:58:22 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:25862 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261885AbVEWO6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:58:15 -0400
To: omb@bluewin.ch
Cc: Patrick McFarland <pmcfarland@downeast.net>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
References: <200505201345.15584.pmcfarland@downeast.net>
	<87acmmf5er.fsf@amaterasu.srvr.nix> <4291EA2D.60504@khandalf.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: a Lisp interpreter masquerading as ... a Lisp interpreter!
Date: Mon, 23 May 2005 15:58:06 +0100
In-Reply-To: <4291EA2D.60504@khandalf.com> (Brian O'Mahoney's message of
 "Mon, 23 May 2005 16:35:25 +0200")
Message-ID: <87wtpqdm69.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005, Brian O'Mahoney said:
> 1__
> 
> The GPL says nothing about using a GPL, or non-free tool to create
> something else, and cannot since it is a copyright based licence.

The point of libgcc is that it is *linked in* to generated programs, and
thus under the FSF's interpretation might force those programs to be
covered by the GPL. Hence the exception, to make it clear that this is
not the case.

(It is even more necessary for the libstdc++ headers and Ada runtime,
as they are respectively textually included and included in cross-module
inlining...)

> 2__
> 
> He has decided what the answer MUST be ... now the reasoning. Here we
> have a Solaris shill!

Nah, it's not that simple: apparently he flames them, too. I think we
can safely say he is no-one's pansy. (Now he might be impossible to
please, but that's a different matter.)

-- 
`Once again, I must remark on the far-reaching extent of my
 ladylike nature.' --- Rosie Taylor
