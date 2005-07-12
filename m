Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVGLFAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVGLFAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 01:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVGLFAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 01:00:38 -0400
Received: from hera.kernel.org ([209.128.68.125]:48589 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262365AbVGLFAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 01:00:22 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: zImage on 2.6?
Date: Tue, 12 Jul 2005 05:00:04 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <daviok$8il$1@terminus.zytor.com>
References: <20050503012951.GA10459@animx.eu.org> <20050503164012.GE11937@animx.eu.org> <200505031742.40554.rick@microway.com> <20050503222328.GE12199@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1121144404 8790 127.0.0.1 (12 Jul 2005 05:00:04 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 12 Jul 2005 05:00:04 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050503222328.GE12199@animx.eu.org>
By author:    Wakko Warner <wakko@animx.eu.org>
In newsgroup: linux.dev.kernel
> 
> Not all machines are PXE capable.  The boot will be generally CDrom or USB
> stick.  I wanted to continue to support our machines that are not capable of
> booting from either of these (which all of these are not PXE capable)
> 

You can stick a recent version of Etherboot on your CD-ROM or USB
stick and use that as your PXE stack.

	-hpa
