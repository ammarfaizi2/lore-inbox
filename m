Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTKYKFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTKYKFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:05:32 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:44447 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S262196AbTKYKF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:05:29 -0500
Date: Tue, 25 Nov 2003 11:05:26 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: AlberT@SuperAlberT.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: hyperthreading
Message-ID: <20031125100526.GE339@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <20031125094419.GB339@vega.digitel2002.hu> <200311251048.53046.AlberT_NOSPAM_@SuperAlberT.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200311251048.53046.AlberT_NOSPAM_@SuperAlberT.it>
X-Operating-System: vega Linux 2.6.0-test9 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 10:48:51AM +0100, Emiliano 'AlberT' Gabrielli wrote:
[...]
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> > bogomips        : 3334.14
> 
> 
> P4 does not support HT ... only Xeon and new generation P4-HT does.

OK, but if this CPU does not support HT, then why 'ht' is shown at
flags in /proc/cpuinfo? It looks like quite illogical for me then ...

- Gábor (larta'H)
