Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273016AbTHNSMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273078AbTHNSMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:12:35 -0400
Received: from topaz-57.mcs.anl.gov ([140.221.57.209]:32640 "EHLO topaz")
	by vger.kernel.org with ESMTP id S273016AbTHNSMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:12:34 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 boot hang
References: <Pine.LNX.4.44.0308141428330.3360-100000@localhost.localdomain>
From: Narayan Desai <desai@mcs.anl.gov>
Date: Thu, 14 Aug 2003 13:12:17 -0500
In-Reply-To: <Pine.LNX.4.44.0308141428330.3360-100000@localhost.localdomain> (Marcelo
 Tosatti's message of "Thu, 14 Aug 2003 14:29:13 -0300 (BRT)")
Message-ID: <87znicjegu.fsf@mcs.anl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Marcelo" == Marcelo Tosatti <marcelo@conectiva.com.br> writes:

  Marcelo> Do you have the NMI watchdog on? If not please turn it on,
  Marcelo> it should give us useful information.

It is an SMP box APIC turned on, so i think this support is already in
the kernel. I booted it with nmi_watchdog=1 and it didn't produce any
extra output, even after waiting...is there anything else i can do?
thanks...
 -nld


