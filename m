Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271423AbTGXJ0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271424AbTGXJ0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:26:24 -0400
Received: from aneto.able.es ([212.97.163.22]:8649 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271423AbTGXJ0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:26:23 -0400
Date: Thu, 24 Jul 2003 11:41:29 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: passing my own compiler options into linux kernel compiling
Message-ID: <20030724094129.GC8172@werewolf.able.es>
References: <200307240916.17530.cijoml@volny.cz> <20030724100111.343d84cd.martin.zwickel@technotrend.de> <200307241050.25094.cijoml@volny.cz> <20030724095505.A28118@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030724095505.A28118@infradead.org>; from hch@infradead.org on Thu, Jul 24, 2003 at 10:55:05 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.24, Christoph Hellwig wrote:
> On Thu, Jul 24, 2003 at 10:50:25AM +0200, Michal Semler wrote:
> > Hi,
> > 
> > -O4 is a feature - for example MPlayer (www.mplayerhq.hu) using it.
> 
> Maybe you and the mplayer folks want to take a look at gcc's "handling"
> of -O4..
> 

BTW, is there any way to get from gcc the options it uses when you
put -ON in the options ?
(It's not I don't trust documentation, just want to double check ;))

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre7-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
