Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTDKOeo (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 10:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTDKOeo (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 10:34:44 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:28801 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264370AbTDKOen (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 10:34:43 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111448.h3BEmpEk001276@81-2-122-30.bradfords.org.uk>
Subject: Re: kernel support for non-English user messages
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 11 Apr 2003 15:48:51 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), Riley@Williams.Name (Riley Williams),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1050066695.14154.22.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Apr 11, 2003 02:11:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Wouldn't we be better off just more fully documenting the English
> > error messages, though, and possibly translating that explaination
> > document in to as many languages as possible?  A lot of people search
> > for error messages strings in the LKML archives, and variations of the
> > same string will hinder this.
> 
> I don't think thats going to happen much. And to document them you have
> enumerate them so its still the same problem space strangely enough

I don't mean document them within the source, I mean a separate
document, (distributed with the source), that people can refer to to
find out what errors really mean.  That solves the verbose/non
versbose and translation problems.  Users simply do a substring search
of the manual for the error they're getting, and get an explaination
in any language that manual has been translated in to.  It doesn't
have to be limited to errors, either, there are a lot of undocumented
informational messages in the kernel, too.

I'd be happy to maintain such a document, but there doesn't seem much
interest in it, and I can't see why.

John.
