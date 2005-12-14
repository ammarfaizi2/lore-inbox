Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVLNTZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVLNTZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVLNTZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:25:22 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:51421 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964910AbVLNTZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:25:21 -0500
Date: Wed, 14 Dec 2005 20:25:19 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kir Kolyshkin <kir@openvz.org>, "Serge E. Hallyn" <serue@us.ibm.com>
Cc: vserver@list.linux-vserver.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Vserver] Re: [ANNOUNCE] second stable release of Linux-VServer
Message-ID: <20051214192519.GE6778@MAIL.13thfloor.at>
Mail-Followup-To: Kir Kolyshkin <kir@openvz.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>, vserver@list.linux-vserver.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051213185650.GA6466@MAIL.13thfloor.at> <Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com> <20051214143819.GB20138@sergelap.austin.ibm.com> <20051214164736.GD6778@MAIL.13thfloor.at> <43A04FC8.4080104@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A04FC8.4080104@openvz.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 08:00:56PM +0300, Kir Kolyshkin wrote:
> Herbert Poetzl wrote:
> 
> >>Additionally, the pid virtualization we've
> >>been discussing (and which should be submitted soon) would remove the
> >>need for the tasklookup patch, so bsdjail would reduce even further,
> >>to network and simple access controls.
> >>   
> >>
> >complete pid virtualization would be interesting for
> >migration and checkpointing too (not just isolation
> >and security), so I think that might be something of
> >interest for a broader audience ...
> > 
> Just to make sure everybody is aware:
> pids are already virtualized in OpenVZ.
> If you want to look at the code, it is available
> from within diff-openvz-ve patch, see
> http://ftp.openvz.org/kernel/broken-out/022stab053.1/

Serge, Kir,

would be great if you both could provide a broken
out version of the pid virtualization for discussion

TIA,
Herbert

> _______________________________________________
> Vserver mailing list
> Vserver@list.linux-vserver.org
> http://list.linux-vserver.org/mailman/listinfo/vserver
