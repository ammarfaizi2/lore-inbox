Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUHHCdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUHHCdv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUHHCdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:33:51 -0400
Received: from fep19.inet.fi ([194.251.242.244]:53456 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S264980AbUHHCdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:33:45 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Sun, 8 Aug 2004 05:33:39 +0300
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de> <1091916508.19077.24.camel@localhost.localdomain> <yw1xu0ve1qqa.fsf@kth.se>
In-Reply-To: <yw1xu0ve1qqa.fsf@kth.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408080533.40147.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 August 2004 02:19, Måns Rullgård wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > BTW while I remember cdrecord has a bug with hardcoded iso8859-1
> > copyright symbols in it which mean your copyright banner is invalid
> > unicode on a UTF-8 locale.
> 
> Does that also invalidate the copyright?
> 

I was under the impression that printing copyright symbols isn't required.
You have copyright on what you write unless you explicitly assign it away,
which supposedly isn't even possible in some parts of the world, that is,
you always retain copyright nomatter what.

<insert standard IANAL(IACOTW) disclaimer>
