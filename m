Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268272AbTGINpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268277AbTGINpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:45:00 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:10676 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S268272AbTGINon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:44:43 -0400
Date: Wed, 9 Jul 2003 16:01:40 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-ID: <20030709140140.GA21978@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706183453.74fbfaf2.skraw@ithnet.com> <1057515223.20904.1315.camel@tiny.suse.com> <20030709140138.141c3536.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709140138.141c3536.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 02:01:38PM +0200, Stephan von Krawczynski wrote:
>I tried to produce some useful output but failed. Additionals I found:
>
>- pre3-ac1 has the same problem
>- the box _hangs_ in fact, no sysrq is working.
>  (you need hw-reset to revive the box)
>- I can see no disk activity on the 3ware RAID in question
>- It always shows up, completely reproducable
>- It shows during boot and during single- or multiuser (mount from console)
>
>Regards,
>Stephan

Which mainboard do you use ?
I'm having endless pain with a 3ware raid and Tyan mainboards, so much I
really really want to replace it with anything else that is stable
(probably a single Intel P4).

v
