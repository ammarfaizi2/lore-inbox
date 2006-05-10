Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWEJN17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWEJN17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWEJN17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:27:59 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:40391 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964947AbWEJN16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:27:58 -0400
Date: Wed, 10 May 2006 09:27:48 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Gleb Natapov <gleb@minantech.com>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm 00/02] update to Document futex PI design
In-Reply-To: <20060510124600.GN5319@minantech.com>
Message-ID: <Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu>
 <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com> <20060510124600.GN5319@minantech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

The following two patches update the rt-mutex-design.txt document.

The first one simply removes all the tabs that I had in that document.
Since it's a document and not code, tabs are not really appropiate.

The second patch tries to explain the "lock" term better.

-- Steve
