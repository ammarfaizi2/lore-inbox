Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272484AbTHSSIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272447AbTHSSIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:08:50 -0400
Received: from aneto.able.es ([212.97.163.22]:40180 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S272635AbTHSSAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:00:51 -0400
Date: Tue, 19 Aug 2003 20:00:49 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCO's "proof"
Message-ID: <20030819180049.GA10670@werewolf.able.es>
References: <3F422809.7080806@yahoo.com> <20030819153056.GB3059@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030819153056.GB3059@gtf.org>; from jgarzik@pobox.com on Tue, Aug 19, 2003 at 17:30:56 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.19, Jeff Garzik wrote:
> On Tue, Aug 19, 2003 at 09:37:13AM -0400, Brandon Stewart wrote:
> > compliments of "d1rkinator" from yahoo finance message board:
> > 
> > The code SCO finds offending:
> > 
> > www.heise.de/newsticker/data/jk-19.08.03-000/imh0.jpg
> > www.heise.de/newsticker/data/jk-19.08.03-000/imh1.jpg
> 
> Why the heck is ia64 inventing its own mutex spinlocks?
> 

They can't even copy code to a slide:

	if (size==0)
		return)((ulong_t NULL);

That does not compile...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-rc2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
