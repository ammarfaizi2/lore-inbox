Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTKYKcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTKYKcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:32:36 -0500
Received: from main.gmane.org ([80.91.224.249]:60546 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262283AbTKYKce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:32:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: hyperthreading
Date: Tue, 25 Nov 2003 11:32:31 +0100
Message-ID: <yw1xptfgd9hc.fsf@kth.se>
References: <20031125094419.GB339@vega.digitel2002.hu> <200311251048.53046.AlberT_NOSPAM_@SuperAlberT.it>
 <20031125100526.GE339@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:uqtj7VNZssxnBloCW8K+o1WgbAc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gábor Lénárt <lgb@lgb.hu> writes:

>> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
>> > bogomips        : 3334.14
>> 
>> 
>> P4 does not support HT ... only Xeon and new generation P4-HT does.
>
> OK, but if this CPU does not support HT, then why 'ht' is shown at
> flags in /proc/cpuinfo? It looks like quite illogical for me then ...

I've been wondering about that myself.  I'm sure my P4M doesn't have
any hyperthreading.

-- 
Måns Rullgård
mru@kth.se

