Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbRBPLkr>; Fri, 16 Feb 2001 06:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129309AbRBPLk2>; Fri, 16 Feb 2001 06:40:28 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:64357 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129243AbRBPLkV>; Fri, 16 Feb 2001 06:40:21 -0500
Date: Fri, 16 Feb 2001 13:40:11 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx troubles with 2.4.1ac6
Message-ID: <20010216134011.C5199@niksula.cs.hut.fi>
In-Reply-To: <20010208135606.F2223@viasys.com> <3A8296E3.FC1EE707@redhat.com> <20010208181601.H2223@viasys.com> <20010215125735.C1147@niksula.cs.hut.fi> <3A8BB89C.581BC524@redhat.com> <20010215132231.F1040@niksula.cs.hut.fi> <20010215141155.D1147@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010215141155.D1147@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Thu, Feb 15, 2001 at 02:11:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2001 at 02:11:55PM +0200, you [Ville Herva] claimed:
> On Thu, Feb 15, 2001 at 01:22:31PM +0200, you [Ville Herva] claimed:
> > On Thu, Feb 15, 2001 at 06:08:12AM -0500, you [Doug Ledford] claimed:
> > > 
> > > There was a new aic7xxx driver (version 5.2.3) that went into the 2.4.1ac
> > > kernel series around 2.4.1-ac7.  I would be curious to know if it worked on
> > > your machine properly.
> > 
> > Ok. Will try. 
> 
> Tried 2.4.1ac13 vanilla. Still a no-go:

Hmm. I think we finally found a fully functional cable.

2.4.1.ac13 vanilla now seems to work flawlessly, even at 160MB/s. Pretty
weird, though, that 2.4.1ac13+Gibbs's aic7xxx worked even with the previous
cable.


-- v --

v@iki.fi
