Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270822AbTG0Pex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270823AbTG0Pex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:34:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29572
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270822AbTG0Pew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:34:52 -0400
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rahul Karnik <rahul@genebrew.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>,
       Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <3F23E538.6010900@genebrew.com>
References: <200307262309.20074.adq_dvb@lidskialf.net>
	 <200307271301.41660.adq_dvb@lidskialf.net> <3F23DB4E.1000203@genebrew.com>
	 <200307271514.00724.adq_dvb@lidskialf.net>  <3F23E538.6010900@genebrew.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059320761.13190.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 16:46:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 15:44, Rahul Karnik wrote:
> Dunno. Look in the list archives for earlier discussions on the topic. 
> It seems AMD audio is a clone of Intel audio, which is why Intel audio 
> works for NForce. Since both audio and ethernet match, it seems unlikely 
> that Nvidia would license a completely different ethernet chip, but who 
> knows?

AMD's older network component is the AMD PCnet32, which is a very
different chip.


