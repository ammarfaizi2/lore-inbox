Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSEVHCj>; Wed, 22 May 2002 03:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSEVHCi>; Wed, 22 May 2002 03:02:38 -0400
Received: from mail012.syd.optusnet.com.au ([210.49.20.170]:47554 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S316878AbSEVHCh>; Wed, 22 May 2002 03:02:37 -0400
Date: Wed, 22 May 2002 17:05:40 +1000
From: Andrew Pam <xanni@glasswings.com.au>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initialisation bug in IDE patch
Message-ID: <20020522170539.L2437@kira.glasswings.com.au>
In-Reply-To: <20020522165709.K2437@kira.glasswings.com.au> <Pine.LNX.4.10.10205212356360.19403-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 11:59:35PM -0700, Andre Hedrick wrote:
> 
> First question for 2.2.X, in your .config is "CONFIG_BLK_DEV_QD6580" set ?
> If not then ide0=qd6580 will yield "-- BAD OPTION"
> 
> Second question for 2.4.X in your .config is "CONFIG_BLK_DEV_QD65XX" set ?
> If not then ide0=qd65xx will yield "-- BAD OPTION"
> 
> Please check those first.

Yes, they are set.

Regards,
	Andrew Pam
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
