Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSGWTtX>; Tue, 23 Jul 2002 15:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318197AbSGWTtX>; Tue, 23 Jul 2002 15:49:23 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:44934 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318194AbSGWTtW>; Tue, 23 Jul 2002 15:49:22 -0400
Date: Tue, 23 Jul 2002 15:52:31 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
Message-ID: <20020723195231.GA14288@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.SOL.4.30.0207231530450.29134-100000@mion.elka.pw.edu.pl> <3D3D6122.5010207@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3D6122.5010207@evision.ag>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 03:58:58PM +0200, Marcin Dalecki wrote:
> That's actually not true... At least the setting of the
> request rq->flags is significantly different here and there.
> However I think but I'm not sure that the fact aht we have rq->special 
> != NULL here has the hidded side effect that we indeed accomplish the
> same semantics.
> 
> >And yes it will be useful to move it to block layer.
> 
> Done. Just needs testing. I have at least an ZIP parport drive, which
> allows me to do some basic checks.

Ehh, you are testing all those IDE changes with a ZIP drive connected to
the parallel port? Don't you have any real IDE devices?? I'm sure we can
all chip in and buy you a drive if you need one.

Jan

