Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbTDAXAn>; Tue, 1 Apr 2003 18:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbTDAXAn>; Tue, 1 Apr 2003 18:00:43 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:1798 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262911AbTDAXAm>; Tue, 1 Apr 2003 18:00:42 -0500
Date: Tue, 1 Apr 2003 15:12:02 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: dpt_i2o memory leak comments
Message-ID: <20030401231202.GC4078@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304012105.h31L5vG11354@hera.kernel.org> <20030401131504.5d25020b.rddunlap@osdl.org> <Pine.LNX.4.53.0304011624030.27457@chaos> <1049232414.20250.17.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049232414.20250.17.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 09:26:54AM +1200, Nigel Cunningham wrote:
> On Wed, 2003-04-02 at 09:26, Richard B. Johnson wrote:
> > Loose means that something is rattling around, not connected, or
> > not tied down. Lose is what happens on the Crap Tables (as above).
> 
> Is it clearer to say: Loose is a state, lose is a verb?

No, because loose is also a verb meaning to make loose or
remove restraints.  English is such a fun language.

To lose something implies the loss is unintended, either
real or pretense.  Unless the loss is unintentional you
really shouldn't be using the word "lose".  If it is
unintentional it should probably be past tense (lost).

At this point I cannot be sure of the context here but what
is probably meant would be clearer if we used the word
"discard".

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
