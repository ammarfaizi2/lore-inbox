Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWFTVPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWFTVPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWFTVPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:15:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:58031 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751099AbWFTVPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:15:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TnbEioZRltiYssDIniPWiKJxtPh2J5biFu65cQHrzfcwxhb/f49O4M9pzuaDkYSbwTZtSFaLDX+B17Ev98/3JyePAgJcgOFuyrDVY6g4LoC9FrBbg5LznbFOQiU5p8fja/ee4gwe7WM/sERsmCTEb2rsFXPY4Nxh0G0qc4TMuRg=
Message-ID: <161717d50606201415t27d9b348y4b2069abb94e0fb3@mail.gmail.com>
Date: Tue, 20 Jun 2006 17:15:31 -0400
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       "Ben Collins" <bcollins@ubuntu.com>,
       "Jody McIntyre" <scjody@modernduck.com>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060620202200.GT27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44954102.3090901@s5r6.in-berlin.de>
	 <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
	 <20060620025552.GO27946@ftp.linux.org.uk>
	 <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
	 <20060620175321.GA7463@flint.arm.linux.org.uk>
	 <44984CA1.5010308@s5r6.in-berlin.de>
	 <20060620193422.GA10748@flint.arm.linux.org.uk>
	 <161717d50606201302o7b13a436wc733c522611b5531@mail.gmail.com>
	 <20060620202200.GT27946@ftp.linux.org.uk>
X-Google-Sender-Auth: 6db2c930295804f8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Tue, Jun 20, 2006 at 04:02:43PM -0400, Dave Neuer wrote:
> > On 6/20/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >
> > >The point was to try to establish when we could consider the tree from
> > >which we'd asked Linus to pull from as being sufficiently old that it
> > >would not be pulled from without another request being sent - or if it
> > >was pulled from, that we wouldn't get an email from Linus about the fact
> > >there was new stuff in there.
> >
> > Can git pull a tag?
>
> Of course, it can.

So "please pull git://somehost/myrepo.git mytag" is a solution?

Dave
