Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293513AbSCKC1p>; Sun, 10 Mar 2002 21:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293516AbSCKC1f>; Sun, 10 Mar 2002 21:27:35 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47098
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293513AbSCKC1b>; Sun, 10 Mar 2002 21:27:31 -0500
Date: Sun, 10 Mar 2002 18:28:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, whitney@math.berkeley.edu,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020311022821.GB311@matchmail.com>
Mail-Followup-To: Benjamin LaHaise <bcrl@redhat.com>,
	"David S. Miller" <davem@redhat.com>, whitney@math.berkeley.edu,
	rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
In-Reply-To: <20020310.170338.83978717.davem@redhat.com> <200203110114.g2B1EuG24994@vindaloo.ras.ucalgary.ca> <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <20020310.180456.91344522.davem@redhat.com> <20020310212210.A27870@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020310212210.A27870@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 09:22:10PM -0500, Benjamin LaHaise wrote:
> On Sun, Mar 10, 2002 at 06:04:56PM -0800, David S. Miller wrote:
> >    From: Wayne Whitney <whitney@math.berkeley.edu>
> >    Date: Sun, 10 Mar 2002 18:05:10 -0800
> >    
> >    So does anyone have any comments on the stability and performance of
> >    these cards/drivers?
> > 
> > As I said in a previous email the natsemi chips don't perform
> > too well.
> 
> That's my fault.  The version of the driver in the kernel atm sucks in 
> performance; I'll try to spend the day needed on the driver this week 
> and it should get up to ~800mbit from the current mess.  Getting NAPI 
> in the kernel would help... ;-)
> 

What is happening with NAPI anyway?
