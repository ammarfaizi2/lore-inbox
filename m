Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751980AbWCFSR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbWCFSR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWCFSR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:17:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15319 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751551AbWCFSR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:17:28 -0500
Date: Mon, 6 Mar 2006 13:17:16 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Ellerman <michael@ellerman.id.au>,
       "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060306181716.GC15971@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	Michael Ellerman <michael@ellerman.id.au>,
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
	Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <20060306125018.GA1673@elf.ucw.cz> <20060306171747.GN21445@redhat.com> <20060306174122.GA2716@elf.ucw.cz> <20060306175238.GA15971@redhat.com> <20060306175811.GB2716@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306175811.GB2716@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 06:58:11PM +0100, Pavel Machek wrote:

 > I just do not want to see CONFIG_DO_NOAPIC_BY_DEFAULT someone suggested
 > here (heh, it is still in subject :-). Whitelist/blacklist is fine
 > with me.

I (and Darrick) already agreed further up in this thread that it wasn't needed.
I think we're actually in agreement ;)

		Dave

-- 
http://www.codemonkey.org.uk
