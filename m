Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTAUTY4>; Tue, 21 Jan 2003 14:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbTAUTY4>; Tue, 21 Jan 2003 14:24:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:53216 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267176AbTAUTY4>; Tue, 21 Jan 2003 14:24:56 -0500
Date: Tue, 21 Jan 2003 11:26:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
cc: acpi-devel@sourceforge.net, mingo@redhat.com
Subject: RE: [PATCH] SMP parsing rewrite, phase 1
Message-ID: <298380000.1043177177@flay>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A12B@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A12B@orsmsx401.jf.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would be a lot easier to read if you could seperate out the
>> renames from the rest of the patch that actually does things.
> ....
> 
> Anyways, I will take a stab at redoing the changesets the way you
> describe.

Cool, will be much easier to see what you're actually changing ;-)
 
>> Anyway, I'll give it a spin on my wierdo box, and see what happens.
> 
> Cool, thanks.

Your latest update makes the NUMA-Q work just fine ;-)
x440 will need that array fixed, I guess.

M.


