Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUAFAX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUAFAX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:23:56 -0500
Received: from hosted-by.pins-web.net ([217.194.100.15]:41881 "EHLO
	katja.worldnetcenter.nl") by vger.kernel.org with ESMTP
	id S266013AbUAFAXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:23:54 -0500
Subject: Re: 2.6.1-rc1 affected?
From: Bastiaan Spandaw <lkml@becobaf.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040105224855.GC4987@louise.pinerecords.com>
References: <1073320318.21198.2.camel@midux>
	 <Pine.LNX.4.58.0401050840290.21265@home.osdl.org>
	 <1073326471.21338.21.camel@midux>
	 <Pine.LNX.4.58.0401051027430.2115@home.osdl.org>
	 <20040105193817.GA4366@lsc.hu>
	 <20040105224855.GC4987@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1073348624.1790.43.camel@louise3.void.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 01:23:44 +0100
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 23:48, Tomas Szepe wrote:
> On Jan-05 2004, Mon, 20:38 +0100
> GCS <gcs@lsc.hu> wrote:
> 
> > There _is_ an exploit: http://isec.pl/vulnerabilities/isec-0013-mremap.txt
> > "Since no special privileges are required to use the mremap(2) system
> ...
> 
> I will not believe the claim until I've seen the code.

Not sure if this works or not.
According to a slashdot comment this is proof of concept code.

http://linuxfromscratch.org/~devine/mremap_poc.c

Regards,

Bastiaan

