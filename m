Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVC3Q6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVC3Q6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 11:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVC3Q6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 11:58:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:28356 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262349AbVC3Q5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 11:57:50 -0500
Subject: Re: [patch 0/8] CKRM: Core patch set
From: Dave Hansen <haveblue@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Paul Jackson <pj@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net,
       "Vivek Kashyap [imap]" <kashyapv@us.ibm.com>
In-Reply-To: <E1DGXEs-0003KX-00@w-gerrit.beaverton.ibm.com>
References: <E1DGXEs-0003KX-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 08:57:30 -0800
Message-Id: <1112201850.11490.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 23:03 -0800, Gerrit Huizenga wrote:
> The code provides a fairly simple mechanism for adding controllers for
> any resource type

Last time I saw the memory controller, it was 3000 lines.  Doesn't seem
too simple to me. :)

Can you post some of the additional controllers that you've been working
on to the appropriate mailing lists, like linux-mm?  If the subject
experts get a good look at the controllers, it's quite possible that
some comments will cascade back to the core, don't you think?

-- Dave

