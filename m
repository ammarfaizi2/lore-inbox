Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSLMHyO>; Fri, 13 Dec 2002 02:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSLMHyO>; Fri, 13 Dec 2002 02:54:14 -0500
Received: from fmr02.intel.com ([192.55.52.25]:28614 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261545AbSLMHyM>; Fri, 13 Dec 2002 02:54:12 -0500
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A10C22274@orsmsx106.jf.intel.com>
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: "'y-goto@jp.fujitsu.com'" <y-goto@jp.fujitsu.com>,
       rusty@linux.co.intel.com
Cc: linux-kernel@vger.kernel.org, fault-injection-developer@sourceforge.net,
       lclaudio@conectiva.com.br, acme@conectiva.com.br,
       olive@conectiva.com.br, riel@conectiva.com.br
Subject: RE: [Fault-injection-developer] [ANNOUNCE] Fault-Injection Test H
	arnessProject
Date: Fri, 13 Dec 2002 00:01:58 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have some infrastructure and a MMIO interceptor implemented so
an interceptor for PCI configuration data is fare game.

Join the mailing list at
http://lists.sourceforge.net/lists/listinfo/fault-injection-developer
and start hacking. :->

  -rusty 

> -----Original Message-----
> From: y-goto@jp.fujitsu.com [mailto:y-goto@jp.fujitsu.com]
> Sent: Thursday, December 12, 2002 11:26 PM
> To: rusty@linux.co.intel.com
> Cc: linux-kernel@vger.kernel.org; 
> fault-injection-developer@sourceforge.net; 
> lclaudio@conectiva.com.br; acme@conectiva.com.br; 
> olive@conectiva.com.br; riel@conectiva.com.br
> Subject: Re: [Fault-injection-developer] [ANNOUNCE] 
> Fault-Injection Test HarnessProject
> 
> 
> Hello Rusty and all.
> 
> I was a developer of LKST, and I know about GKHI's implementation.
> 
> rusty> Fault-Injection Test Harness Project
> rusty> -------------------------------------
> 
> Now, I am interested in your project, and I read white paper for 
> investigation.
> I think that following development items haven't been completed yet.
> Is it correct?
> - Interceptor of PCI configuration. 
> - Caller of Code Segment.
> If these aren't completed yet, I want to develop it.
> 
> Best Regards.
> 
> ---------------五島康文 (GOTO Yasunori)-------------------
> 富士通(株)BCCプロジェクト推進部
> e-mail: y-goto@jp.fujitsu.com
> tel 0559-24-6178(7551-5725) fax 0559-24-6195(7551-6547)
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:
> With Great Power, Comes Great Responsibility 
> Learn to use your power at OSDN's High Performance Computing Channel
> http://hpc.devchannel.org/
> _______________________________________________
> Fault-injection-developer mailing list
> Fault-injection-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/fault-injection-developer
> 
