Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbTICTsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTICTqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:46:54 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1040 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264389AbTICTqc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:46:32 -0400
Date: Wed, 3 Sep 2003 12:30:31 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Guillaume Morin <guillaume@morinfr.org>
cc: James Clark <jimwclark@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
In-Reply-To: <20030903183507.GI905@siri.morinfr.org>
Message-ID: <Pine.LNX.4.10.10309031225250.13722-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Sep 2003, Guillaume Morin wrote:

> Dans un message du 03 Sep à 10:49, Andre Hedrick écrivait :
> > The only solution is to created a GPL pre-loading module with all the
> > GPL_ONLY needed extentions re-exported or externed as to bypass the
> > horse sh*t.
> 
> Which would be a violation of the GPL :
> 
> What is the difference between "mere aggregation" and "combining two
> modules into one program"?  
> 
>    Mere aggregation of two programs means putting them side by side on
> the same CD-ROM or hard disk. We use this term in the case where they
> are separate programs, not parts of a single program. In this case, if
> one of the programs is covered by the GPL, it has no effect on the other
> program.
> 
>     Combining two modules means connecting them together so that they form a
> single larger program. If either part is covered by the GPL, the whole
> combination must also be released under the GPL--if you can't, or won't, do
> that, you may not combine them.
> 
>     What constitutes combining two parts into one program? This is a legal
> question, which ultimately judges will decide. We believe that a proper
> criterion depends both on the mechanism of communication (exec, pipes, rpc,
> function calls within a shared address space, etc.) and the semantics of the
> communication (what kinds of information are interchanged).

You assume wrong.

The Pre-Loader or "freed-symbols" is to return symbols that were once
EXPORT_SYMBOL which are now openly renamed EXPORT_SYMBOL_GPL.

This is open thieft of the kernel API.

So I welcome you and your lawyers to sue me for making a GPL module which
allows free use of the stolen symbols.  Please come to California and lets
party.  Since it is an original work as a new module, regardless if it is
derived or not, being GPL and source available you lose ... Have a nice
day.

Cheers,

Andre


