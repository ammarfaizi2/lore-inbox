Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUBODzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 22:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUBODzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 22:55:41 -0500
Received: from hera.kernel.org ([63.209.29.2]:47590 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263927AbUBODzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 22:55:38 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: kernel.org finger service
Date: Sun, 15 Feb 2004 03:55:15 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0mqj3$cfe$1@terminus.zytor.com>
References: <20040215001237.GB13839@MAIL.13thfloor.at> <402EBCBA.3070502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076817315 12783 63.209.29.3 (15 Feb 2004 03:55:15 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 15 Feb 2004 03:55:15 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <402EBCBA.3070502@pobox.com>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
>
> Herbert Poetzl wrote:
> > hmm, probably everybody knows and there is a good 
> > reason for it, but just for the unlikely case, that 
> > it did went unnoticed ...
> > 
> > the finger services at kernel.org does not return
> > useful information atm.
> > 
> > # finger @kernel.org
> > [kernel.org]
> 
> It's intermittent...
> 

The finger service is low priority and shuts down under high load.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
