Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTFUXH5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTFUXH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:07:57 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:36100 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263749AbTFUXH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:07:56 -0400
Date: Sat, 21 Jun 2003 16:18:22 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72{-mm2} and PCMCIA
Message-ID: <20030621231822.GB31390@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030621194229.2848de6b.ktech@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621194229.2848de6b.ktech@wanadoo.es>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 07:42:29PM +0200, Luis Miguel Garcia wrote:
> Hello:
> 
> I have a Sony Vaio laptop and I cannot make my Network PCMCIA card to run.
> 
> At startup, Yenta Socket is detected and lights from the ethernet card starts flashing but no network interface appears if I do "ifconfig".
> 
> What must I do to enable network capabilities? Is this a bug?
> 
> I can provide dmesg or other necessary things.

Start with the linux on laptops site.  If that doesn't do it
google.

If you still have no solution and do come back here please
indicate which Vaio and which PC card.  Not only is each
model of Vaio different but even a given model may have
different hardware depending on when it was manufactured.
The output of lspci would probably also help.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
