Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTGHScd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbTGHScd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:32:33 -0400
Received: from waste.org ([209.173.204.2]:54158 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265219AbTGHSca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:32:30 -0400
Date: Tue, 8 Jul 2003 13:47:02 -0500
From: oxymoron@waste.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linksys gpl code [OT]
Message-ID: <20030708184702.GS9707@waste.org>
References: <1057663858.3959.41.camel@miyazaki> <1057673100.4358.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057673100.4358.23.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 03:05:01PM +0100, Alan Cox wrote:
> On Maw, 2003-07-08 at 12:30, Matthew Hall wrote:
> > Hi lkml,
> > 	I don't know if anyone's noticed, but Linksys have opened up and
> > released their code.
> 
> BTW - Qlogic have also tidied up their fibre channel stuff that was
> using Linux. Customers can now order the sources at nominal cost, and
> the documentation now includes a clear offer.
> 
> They are also at great pains to state that if you modify your fc switch
> they are absolutely not supporting it any more 8)

For people interested in poking around on their Qlogic switch, it took
John the Ripper all of about 15 seconds to elucidate the root password on
their XFS(!?) firmware image. 

Qlogic press releases indicate you'll find that Cisco embeds Qlogic's
FC switching (and therefore Linux) inside some of their products like
the SN5428, though they probably have yet to follow up on the
documentation side.

http://www.qlogic.com/news-events/details/releases_details.asp?id=1106

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
