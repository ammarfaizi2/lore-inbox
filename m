Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUAFWyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUAFWyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:54:41 -0500
Received: from gate.nmr.mgh.harvard.edu ([132.183.203.69]:2535 "EHLO
	gate.nmr.mgh.harvard.edu") by vger.kernel.org with ESMTP
	id S265953AbUAFWyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:54:37 -0500
Date: Tue, 6 Jan 2004 17:53:34 -0500 (EST)
From: Paul Raines <raines@nmr.mgh.harvard.edu>
To: "Ogden, Aaron A." <aogden@unocal.com>
cc: thockin@Sun.COM, "H. Peter Anvin" <hpa@zytor.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
Message-ID: <Pine.LNX.4.44.0401061746470.16793-100000@gate.nmr.mgh.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As another sysadmin with 300+ linux and solaris boxes, I second
you sentiments exactly.  As my previous post today states, I am
having exactly the problem you describe with automount daemons
becoming hung or unresponsive.  Guess I should give 4.1.0 a try.  

Of course the same arguement applies to NFS server but they went
ahead and moved most of that into the kernel anyway for the 
performance gain.

-- 
---------------------------------------------------------------
Paul Raines                   email: raines@nmr.mgh.harvard.edu
MGH/MIT/HMS Athinoula A. Martinos Center for Biomedical Imaging
149 (2301) 13th Street        Charlestown, MA 02129	USA   




