Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265691AbSKASnp>; Fri, 1 Nov 2002 13:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265692AbSKASnp>; Fri, 1 Nov 2002 13:43:45 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:58340 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S265691AbSKASnp>; Fri, 1 Nov 2002 13:43:45 -0500
Date: Fri, 1 Nov 2002 18:46:30 +0000
From: Malcolm Beattie <mbeattie@clueful.co.uk>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Richard B. Johnson'" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  October 30, 2002
Message-ID: <20021101184630.A10355@clueful.co.uk>
References: <11E89240C407D311958800A0C9ACF7D1A33C8D@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33C8D@EXCHANGE>; from EdV@macrolink.com on Fri, Nov 01, 2002 at 10:17:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Vance writes:
>                                                           Some mainframe
> memory systems do the whole ECC scrub/correction operation in hardware,
> simultaneously in each bank. 

For those interested in the gory details of how the z900 mainframe
does memory scrubbing, see the section on "Memory" in
"RAS design for the IBM eServer z900" by L. C. Alves et al
in the z900 issue of IBM Journal of Research and Development.
HTML version at
    http://www.research.ibm.com/journal/rd/464/alves.html
PDF version at
    http://www.research.ibm.com/journal/rd/464/alves.pdf
Web page for whole issue at
    http://www.research.ibm.com/journal/rd46-45.html

--Malcolm
