Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTDKK6v (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 06:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTDKK6u (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 06:58:50 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:39296 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264330AbTDKK6u (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 06:58:50 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111111.h3BBBu6r000757@81-2-122-30.bradfords.org.uk>
Subject: Re: kernel support for non-english user messages
To: Valdis.Kletnieks@vt.edu
Date: Fri, 11 Apr 2003 12:11:56 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), spotter@cs.columbia.edu (Shaya Potter),
       alan@lxorguk.ukuu.org.uk (Alan Cox), root@chaos.analogic.com,
       fdavis@si.rr.com (Frank Davis),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <200304111059.h3BAx1Bm008076@turing-police.cc.vt.edu> from "Valdis.Kletnieks@vt.edu" at Apr 11, 2003 06:59:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A versioned file becomes openable as a directory as well, so that you
> > can see the old versions.  I'm sure something like this has already
> > been done, I'll have to try to search it out.
> 
> There was "Hidden Directory" support in IBM's AIX/370 (and probably the
> AIX 1.2 that was i386-only), and I'm told some of the HP Apollo stuff
> did similar.  Very strange, bizzare, aggrivating, and occasionally useful.

Well, you can say that about almost any feature, but you can always
compile it out :-).

A versioned filesystem would be very useful for:

* Webservers
* Development of small projects, where you don't need the overhead of
  an SCM, but something similar is useful.

John.
