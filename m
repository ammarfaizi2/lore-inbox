Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVFGWoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVFGWoN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVFGWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:44:12 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:28358 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262028AbVFGWn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:43:59 -0400
Date: Wed, 8 Jun 2005 00:42:11 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050607224211.GA30023@electric-eye.fr.zoreil.com>
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz> <42A5F51B.5060909@pobox.com> <20050607193305.GN2369@mail.muni.cz> <20050607200820.GA25546@electric-eye.fr.zoreil.com> <20050607211048.GO2369@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607211048.GO2369@mail.muni.cz>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> :
[...]
> However, it seems to be highly unstable. Using iperf it gets broken. Card 
> receives packets but it does not transmit after some iperf tests.

Hard to tell without further investigation if there is some kind of
wraparound or some unordered acesses to the asic (or worse).

[...]
> Should I still add an bugzilla entry? Unfortunately, 2.6.6. driver from
> website is accessible only through password.

Is it available under anything like a GPL license ?

--
Ueimor
