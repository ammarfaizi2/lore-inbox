Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTJCBvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 21:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTJCBvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 21:51:12 -0400
Received: from shasta.nbgisp.com ([198.76.39.8]:2310 "EHLO shasta.nbgisp.com")
	by vger.kernel.org with ESMTP id S263583AbTJCBvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 21:51:09 -0400
Reply-To: <paul.brett@planet-lab.org>
From: "Paul Brett" <paul.brett@planet-lab.org>
To: <karim@opersys.com>, "'Keir Fraser'" <Keir.Fraser@cl.cam.ac.uk>
Cc: "'Theodore Ts'o'" <tytso@mit.edu>, <xen-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>,
       "'Jacques Gelinas'" <jack@solucorp.qc.ca>
Subject: RE: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization
Date: Thu, 2 Oct 2003 18:50:05 -0700
Organization: PlanetLab Support
Message-ID: <CA95C29D57188841ABB072EA7357C00D02AE7D08@orsmsx402.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <CA95C29D57188841ABB072EA7357C00D02C13377@orsmsx402.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

|    -----Original Message-----
|    From: xen-devel-admin@lists.sourceforge.net 
|    [mailto:xen-devel-admin@lists.sourceforge.net] On Behalf 
|    Of Karim Yaghmour
|    Sent: Thursday, October 02, 2003 11:42 AM
|    To: Keir Fraser
|    Cc: Theodore Ts'o; xen-devel@lists.sourceforge.net; 
|    linux-kernel@vger.kernel.org; Jacques Gelinas
|    Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen 
|    high-performance x86 virtualization
|    
|    
|    
|    Keir Fraser wrote:
|    > Full recursion needs full virtualization. Our approach 
|    offers much
|    > better performance in the situations where full 
|    virtualization isn't
|    > required -- i.e., where it's feasible to distribute a ported OS.
|    
|    ... So, thinking aloud here, I'm wondering in what
|    circumstances I'd prefer using something as architecture 
|    specific as Xen over something as architecture independent
|    as Jacques' 

And of course, you can always run many vservers inside a single Xen
domain to get the best of both worlds.

Paul Brett
PlanetLab Support
Email: paul.brett@planet-lab.org
Tel No: +1 503 712 4520

