Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261589AbSJDMw5>; Fri, 4 Oct 2002 08:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbSJDMw5>; Fri, 4 Oct 2002 08:52:57 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:34295 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261589AbSJDMw4>; Fri, 4 Oct 2002 08:52:56 -0400
Subject: Re: EVMS Submission for 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kcorry@austin.rr.com
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       evms-devel@lists.sourceforge.net
In-Reply-To: <02100319394801.00236@cygnus>
References: <02100216332002.18102@boiler> <02100316563708.05904@boiler>
	<20021003230728.GF2289@kroah.com>  <02100319394801.00236@cygnus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 14:06:29 +0100
Message-Id: <1033736789.31839.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 01:39, Kevin Corry wrote:
> Yep, you guessed it. I'm no big fan of Lindent. In my opinion, it makes some 
> really bad choices about how to break long lines (among other things), as 
> you've kindly pointed out. But, I had to start somewhere and wanted to get 
> something out before I left for the day. Obviously the AIX plugin will need 
> some additional attention at some point.

IMHO the Lindent script is broken. It should also specify a line length
of something like 256 so it doesnt go mashing lines. 


