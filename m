Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTFJAd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 20:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTFJAd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 20:33:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21669
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262328AbTFJAd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 20:33:58 -0400
Subject: RE: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
In-Reply-To: <Pine.LNX.4.55L.0306091901260.27584@freak.distro.conectiva>
References: <F760B14C9561B941B89469F59BA3A84725A2DF@orsmsx401.jf.intel.com>
	 <Pine.LNX.4.55L.0306091901260.27584@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055205899.31139.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jun 2003 01:44:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-09 at 23:03, Marcelo Tosatti wrote:
> Yes, I want to, and will merge it. In 2.4.23-pre.
> 
> > I am confident it will merge cleanly.
> > I am confident it will cause no problems when CONFIG_ACPI=off.
> > I am confident the total number of working machines will go up.
> > I am willing to bet $500 of MY OWN MONEY on this.
> >
> > Talk to me, man. What would make you happy? A lot is riding on this.
> 
> Yes, we're fine. 2.4.23-pre.
> 
> 2.4.22 will be a fast enough release to not piss you off on this, trust
> me.

Its been in 2.4.21-ac for a while. I have exactly zero reports of it
causing problems in the acpi=n case, and a whole raft of "the first
Linux that runs on my toshiba/compaq/hp laptop"

Works well enough for me to have faith in it now. 


