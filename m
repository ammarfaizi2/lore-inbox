Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTJTVlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTJTVlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:41:07 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:471 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262221AbTJTVlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:41:05 -0400
Date: Mon, 20 Oct 2003 23:30:45 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Donald Becker <becker@scyld.com>, linux-net@vger.kernel.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.22 and SMC EtherPower II 9432
Message-ID: <20031020233045.A14712@electric-eye.fr.zoreil.com>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	Adrian Bunk <bunk@fs.tum.de>, Donald Becker <becker@scyld.com>,
	linux-net@vger.kernel.org, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <20031020205933.GS23191@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031020205933.GS23191@fs.tum.de>; from bunk@fs.tum.de on Mon, Oct 20, 2003 at 10:59:33PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> :
[...]
> on two different machines the ethernet card works with kernel 2.2.20 but 
> not with kernel 2.4.22 (both contain machines contain the same card).

Could you display the registers with the utility available at
<URL:ftp://ftp.scyld.com/pub/diag/epic-diag.c> ?

--
Ueimor
