Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUGVRJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUGVRJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 13:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUGVRJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:09:01 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:19960 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S265215AbUGVRI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:08:59 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.7 oops, sk98lin related?
Date: Thu, 22 Jul 2004 19:08:38 +0200
User-Agent: KMail/1.6.2
References: <200407221101.16388.bernd-schubert@web.de> <20040722150314.GB13195@infradead.org>
In-Reply-To: <20040722150314.GB13195@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407221908.41468.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > is this an sk98lin oops, maybe related to your patches or is it a
> > completely different problem?
>
> I don't think there's skge patches from me in 2.6.7 yet, but certainly not
> in that area ;-)

Well just remember, on 20040704 you send me a 'huge patch' which should also 
fix our module unload problems.

>
> This is just a big memory allocation failing, not an oops anyway.

Unfortunality I began to capture via serial console only a few hour after the 
server crashed. As there is also nothing in the logs, I don't have the 
beginning trace of the problems.

Since there is something about sk98 in almost all traces, I thought it might 
be a sk98lin problem.

Anyway, do you have an idea what might have cause this memory allocation 
problem?


Thanks,
	Bernd


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
