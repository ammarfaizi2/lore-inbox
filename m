Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbTFCEB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 00:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTFCEB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 00:01:59 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:19842
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264924AbTFCEB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 00:01:58 -0400
Date: Tue, 3 Jun 2003 00:03:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Con Kolivas <kernel@kolivas.org>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Paul P Komkoff Jr <i@stingr.net>, "" <linux-kernel@vger.kernel.org>
Subject: Re: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
In-Reply-To: <200306031201.09642.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.50.0306030002010.14455-100000@montezuma.mastecende.com>
References: <F760B14C9561B941B89469F59BA3A84725A2CC@orsmsx401.jf.intel.com>
 <200306031012.07832.kernel@kolivas.org> <200306031201.09642.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003, Con Kolivas wrote:

> At least I can provide you with the acpi info from dmesg when it booted, and 
> I'll try Zwane's hack in the near future to see if it helps.

Andrew, i picked this up on the tailend of another bug report, there 
should be a new one opened but i haven't checked. I presume the tree you 
have in 2.5.70 and 2.4.21rc6-ac1 are relatively the same.

http://bugzilla.kernel.org/show_bug.cgi?id=370

-- 
function.linuxpower.ca
