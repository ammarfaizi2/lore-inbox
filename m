Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265419AbTFMQKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbTFMQKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:10:36 -0400
Received: from origo.imsb.au.dk ([192.38.35.2]:37560 "EHLO origo.imsb.au.dk")
	by vger.kernel.org with ESMTP id S265419AbTFMQJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:09:18 -0400
Date: Fri, 13 Jun 2003 19:22:56 +0200 (CEST)
From: Morten Kjeldgaard <mok@imsb.au.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: fatal error with nForce2 system
In-Reply-To: <1055493950.5169.15.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306131919370.12961-100000@origo.imsb.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan,

> The hang and the Nvidia driver crash may be unrelated problems
> unfortunately. The first candidate is probably to run memtest86 on
> the system, and then to check the usual suspects (fan, psu voltage). 

I'll go over the system with a fine comb, to make sure it is not hardware 
related. Then I'll see if I can reproduce the crashes without the nVidia 
drivers ever having been loaded.

Morten

-- 
Morten Kjeldgaard <mok@imsb.au.dk>
Department of Molecular Biology, Aarhus University
Gustav Wieds Vej 10 C, DK-8000 Aarhus C, Denmark
Lab +45 89425026 * Mobile +45 89428063 * Fax +45 86123178
Home +45 86188180 * ICQ 27224900 * http://imsb.au.dk/~mok

