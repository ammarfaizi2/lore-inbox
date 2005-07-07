Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVGGDBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVGGDBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 23:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVGGDBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 23:01:41 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:33806 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262419AbVGGDBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 23:01:09 -0400
Date: Wed, 6 Jul 2005 22:52:46 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Doug Wicks <doug@ccbill.com>
Cc: Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Hubert Chan <hubert@uhoreg.ca>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
Message-ID: <20050707025246.GA2181@mail>
Mail-Followup-To: Doug Wicks <doug@ccbill.com>,
	Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
	Hubert Chan <hubert@uhoreg.ca>,
	"Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
	vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
	ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com,
	hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com, zam@namesys.com, vs@thebsh.namesys.com,
	ndiller@namesys.com, vitaly@thebsh.namesys.com
References: <889A47B16278164FB657E0FFB1CAB8C7B729A7@hq-exchange.ccbill-hq.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889A47B16278164FB657E0FFB1CAB8C7B729A7@hq-exchange.ccbill-hq.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/05 03:54:09PM -0700, Doug Wicks wrote:
> How do I get off the mail list here? 

Read the auto-appended signature at the bottom of every message.
> 
>  
> doug@cavecreek.com
>  
> 

Jim.

> -----Original Message-----
> From: Hans Reiser [mailto:reiser@namesys.com] 
> Sent: Wednesday, July 06, 2005 3:50 PM
> To: David Masover
> Cc: Hubert Chan; Alexander G. M. Smith; ross.biro@gmail.com;
> vonbrand@inf.utfsm.cl; mrmacman_g4@mac.com; Valdis.Kletnieks@vt.edu;
> ltd@cisco.com; gmaxwell@gmail.com; jgarzik@pobox.com; hch@infradead.org;
> akpm@osdl.org; linux-kernel@vger.kernel.org; reiserfs-list@namesys.com;
> zam@namesys.com; vs@thebsh.namesys.com; ndiller@namesys.com;
> vitaly@thebsh.namesys.com
> Subject: Re: reiser4 plugins
> 
> David Masover wrote:
> 
> > So, will the format change happen at mount time?  Will it need a
> > special mount flag?  Will I need to use debugfs or some other offline
> > tool?
> 
> 
> First we make sure we have the right answer.  Have we solved the cycle
> problem?  Can we run out of memory as Horst/Nikita suggest?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
