Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbTIEMMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 08:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbTIEMMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 08:12:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13184 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262487AbTIEMMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 08:12:07 -0400
Date: Fri, 5 Sep 2003 13:25:24 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309051225.h85CPOYr000323@81-2-122-30.bradfords.org.uk>
To: clemens-dated-1063627487.e072@endorphin.org, joern@wohnheim.fh-wedel.de
Subject: Re: nasm over gas?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Are there any buffer overflows or other security holes?
> > How can you be sure about it?
>
> How can you be sure? Mathematical program verification applies quite badly
> to assembler.

The point is, if somebody does find a bug they will want to
re-assemble with Gas after they've fixed it.

> > If your code fails on any one of these questions, forget about it.  If
> > it survives them, post your results and have someone else verify them.
>
> I'm sorry, your critique is too generel to be useful.

It's not, all the time the argument is not against the assembler code,
but rather against $assembler!=Gas.

John.
