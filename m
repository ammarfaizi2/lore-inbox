Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUBDTkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUBDTkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:40:20 -0500
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:131 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id S263726AbUBDTkM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:40:12 -0500
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16417.19084.870196.696467@ronispc.chem.mcgill.ca>
Date: Wed, 4 Feb 2004 14:39:56 -0500
To: "Juergen E. Fischer" <fischer@linux-buechse.de>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Problem with module-init-tools-3.0-pre3
In-Reply-To: <20040204193154.GA29661@linux-buechse.de>
References: <16417.14736.420280.796948@ronispc.chem.mcgill.ca>
	<20040204193154.GA29661@linux-buechse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: david.ronis@mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jurgen,

Without.  [Can you point me to it?  I'll give it a try].

David

Juergen E. Fischer writes:
 > Hi David,
 > 
 > On Wed, Feb 04, 2004 at 13:27:28 -0500, David Ronis wrote:
 > > I just built 2.6.2 and tried the scsi driver install/remove problem I
 > > wrote about earlier (if, I manually remove the sg and aha152x modules
 > > with modprobe, I get an oops the next time they are used).  The
 > > problem is still present.
 > 
 > With or without the patch?  It wasn't applied in 2.6.2.
 > 
 > 
 > Jürgen
 > 
 > -- 
 > Phase 1: Where do you want to go today?
 > Phase 2: This is where you want to go today.
 > Phase 3: You're not going anywhere today.
 >   -- seen on /.
