Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbUKYBMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUKYBMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUKYBKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:10:45 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:42723 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S262884AbUKYBJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:09:38 -0500
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message
	when suspending
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@linuxmail.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101330362.3895.24.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294838.5805.245.camel@desktop.cunninghams>
	 <1101312041.8940.45.camel@localhost>
	 <1101330362.3895.24.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101335142.8940.429.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 24 Nov 2004 14:25:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 13:06, Nigel Cunningham wrote:
> On Thu, 2004-11-25 at 03:00, Dave Hansen wrote:
> > Following Documentation/SubmittingPatches, please submit patches made
> > with "diff -urp":
> > 
> >        -p  --show-c-function
> >               Show which C function each change is in.
> > 
> > Otherwise, it's a lot harder to figure out what you're modifying.
> 
> Okay; thanks. I wont go redoing all of the patches now, but are there
> specific ones you'd like to see?

I'd just add it to whatever scripts you use to publish patches and do it
that way from now on for all of them.

-- Dave

