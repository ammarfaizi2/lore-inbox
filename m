Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWFHGlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWFHGlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWFHGlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:41:55 -0400
Received: from gw.openss7.com ([142.179.199.224]:48317 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932534AbWFHGlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:41:55 -0400
Date: Thu, 8 Jun 2006 00:41:53 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Message-ID: <20060608004153.A11953@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <p73ejy0tm83.fsf@verdi.suse.de> <20060607220118.f0c64086.akpm@osdl.org> <200606080739.33967.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606080739.33967.ak@suse.de>; from ak@suse.de on Thu, Jun 08, 2006 at 07:39:33AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Thu, 08 Jun 2006, Andi Kleen wrote:
> 
> Nothing on x86-64 at least - it uses -fno-reorder-blocks by default.
> 

Why is that?

--brian
