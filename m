Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWJQOFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWJQOFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWJQOFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:05:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63161 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751034AbWJQOFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:05:33 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161093310.4937.37.camel@localhost> 
References: <1161093310.4937.37.camel@localhost>  <200610161658.58288.ak@suse.de> <1161058535.11489.6.camel@localhost> <200610171250.56522.ak@suse.de> 
To: Ian Kent <raven@themaw.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: BUG dcache.c:613 during autofs unmounting in 2.6.19rc2 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 17 Oct 2006 15:05:07 +0100
Message-ID: <23461.1161093907@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> There have been some changes in this area (David Howells made some
> changes which affected autofs4) and I'm not sure that the autofs module
> was reviewed. I didn't look closely at it at the time, I guess I should
> have. Sorry.

It looks like my fixes for autofs4 need applying to autofs also.

David
