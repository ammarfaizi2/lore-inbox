Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUCRPom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbUCRPni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:43:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32994 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262719AbUCRPnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:43:20 -0500
Date: Thu, 18 Mar 2004 10:42:15 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Alok Mooley <rangdi@yahoo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       vijay agashe <pushkaragashe@hotmail.com>
Subject: Re: Active defragmentation : A replacement for bigphysarea?
In-Reply-To: <20040317173607.31415.qmail@web9706.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0403181040510.16728-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Alok Mooley wrote:

> I have implemented a memory defragmentation utility
> for linux kernel 2.6 based on the paper by Mr. Daniel
> Phillips.

That's very interesting, but:
1) what is your name, "Alok Mooley" or "Vijay Agashe" ? ;)
2) could we please see your code, so we can try to answer
   your questions ?

> Can this utility be used instead of the bigphysarea
> patch, for requirements less than MAX_ORDER of
> allocation ?

This question is really hard to answer without seeing the
code.

kind regards,

Rik van Riel
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


