Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272500AbTHEPnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272503AbTHEPnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:43:14 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:34467 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272500AbTHEPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:43:13 -0400
Date: Tue, 5 Aug 2003 17:42:37 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE as modules in 2.4.21
Message-ID: <20030805154237.GC18982@louise.pinerecords.com>
References: <20030805110458.A6070@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805110458.A6070@animx.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [wakko@animx.eu.org]
> 
> I get a circular dependancy problem when I compile IDE as modules.  It did
> not do this with 2.4.20.
> 
> ide.o depends on ide-lib and ide-iops
> ide-iops.c depends on ide and ide-lib

Modular IDE got fixed some time after 2.4.21 was released.

-- 
Tomas Szepe <szepe@pinerecords.com>
