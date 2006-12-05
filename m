Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758461AbWLESFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461AbWLESFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968551AbWLESFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:05:44 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4181 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758461AbWLESFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:05:43 -0500
Date: Tue, 5 Dec 2006 18:05:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Steve Fox <drfickle@linux.vnet.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       afleming@freescale.com
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <1165259836.23190.48.camel@flooterbu>
Message-ID: <Pine.LNX.4.64N.0612051804200.7108@blysk.ds.pg.gda.pl>
References: <1165125055.5320.14.camel@gullible>  <20061203011625.60268114.akpm@osdl.org>
 <1165259836.23190.48.camel@flooterbu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Steve Fox wrote:

> Unfortunately Maciej didn't get cc'ed correctly on your mail. Hopefully
> I've added the right person to this post as well as Andy who has also
> recently changed this code.

 Thanks -- my parser of the LKML does not always trigger.

  Maciej
