Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946446AbWJ0L76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946446AbWJ0L76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946447AbWJ0L76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:59:58 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:43353 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1946446AbWJ0L76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:59:58 -0400
Subject: Re: [S390] Add ipl/reipl loadparm attribute.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: mschwid2@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <OFD298AD6D.26BA86C4-ON42257214.0041A504-42257214.0041B155@de.ibm.com>
References: <OFD298AD6D.26BA86C4-ON42257214.0041A504-42257214.0041B155@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: IBM Corporation
Date: Fri, 27 Oct 2006 13:59:54 +0200
Message-Id: <1161950395.2247.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 13:57 +0200, Michael Holzheu wrote:
> Der patch hat eine Abhängikeit auf den strstrip patch.
> 
> Muss man das irgendwo dokumentieren?

Nö, Andrew wird den strstrip patch so wie es aussieht noch in 2.6.19
unterbringen und da ist der loadparm patch auch drin.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


