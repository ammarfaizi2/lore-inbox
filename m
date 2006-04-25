Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWDYI6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWDYI6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWDYI6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:58:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:14096 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932147AbWDYI6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:58:38 -0400
Date: Tue, 25 Apr 2006 10:58:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Avi Kivity <avi@argo.co.il>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <20060425085822.GA12258@mars.ravnborg.org>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <444DA2CA.4060807@mbligh.org> <444DB3FC.3070802@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444DB3FC.3070802@argo.co.il>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 08:30:36AM +0300, Avi Kivity wrote:
> Martin J. Bligh wrote:
> >
> >So ... what exactly are you waiting for? We await the results with
> >baited breath. This slick C++ kernel of which you speak can surely
> >not be far away.
> >
> I'll start on converting 2.6.16 tomorrow, since you're anticipating it 
> with such eagerness.
If you search the archives you can find a simple kbuild patch to
introduce C++ support.
OK, googled a little:
http://www.ussg.iu.edu/hypermail/linux/kernel/0509.2/0549.html

I wrote it for someone that requested it long ago - and never applied it
to vanilla kernel.

They had done the hard stuff themself - adapting the rest of the kernel
to be compileable by a C++ compiler.

	Sam
