Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318709AbSHAMwj>; Thu, 1 Aug 2002 08:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318729AbSHAMwj>; Thu, 1 Aug 2002 08:52:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:4335 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318709AbSHAMwi>; Thu, 1 Aug 2002 08:52:38 -0400
Subject: Re: [2.6] The List, pass #2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200208010156.g711uMc340112@saturn.cs.uml.edu>
References: <200208010156.g711uMc340112@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 15:12:58 +0100
Message-Id: <1028211178.14871.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 02:56, Albert D. Cahalan wrote:
> Guillaume Boissier writes:
> 
> > Definitely 2.7:
> >
> > o InfiniBand support
> 
> Why?
> 
> Sure, one could get fancy, but just running SCSI or IP
> over InfiniBand can't be that complicated... hmmm?

Intel canned their hardware, Microsoft apparently canned support in
their upcoming product short term, nobody has a ready to go stack.

SCSI over infiniband should work nicely with little work. IP over
infiniband is a bit more complicated, at least until they actually
implement the congestion control in the fabric

