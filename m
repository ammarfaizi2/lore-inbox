Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWDGU2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWDGU2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWDGU2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:28:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:6031 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964926AbWDGU2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:28:12 -0400
X-Authenticated: #342784
From: jensmh@gmx.de
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: 2.6.16.1 lost cpu, was: 2.6.16-rc5 'lost' cpu
Date: Fri, 7 Apr 2006 22:27:56 +0200
User-Agent: KMail/1.9.1
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0603030954230.28074@montezuma.fsmlabs.com> <200604071845.38371.jensmh@gmx.de> <20060407132206.A27131@unix-os.sc.intel.com>
In-Reply-To: <20060407132206.A27131@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072227.58594.jensmh@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj writes:
> On Fri, Apr 07, 2006 at 06:45:36PM +0200, jensmh@gmx.de wrote:
> 
> Oh well, seems like that CPU has trouble booting, per message below
> we seemed to start it, but processor didnt run startup code... Suspect its a 
> failing part probably..
> 
> > CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> > CPU1: Thermal monitoring enabled
> > CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
> > Booting processor 2/6 eip 2000

shouldn't that be "Booting processor 2/_4_ eip 2000"?

> > CPU 2 irqstacks, hard=c04b8000 soft=c04b0000
> > Not responding.
> > Inquiring remote APIC #6...
> > ... APIC #6 ID: failed
> > ... APIC #6 VERSION: failed
> > ... APIC #6 SPIV: failed
> > CPU #6 not responding - cannot use it.
> 
