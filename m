Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWEaIAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWEaIAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWEaIAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:00:12 -0400
Received: from gw.openss7.com ([142.179.199.224]:17388 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S964829AbWEaIAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:00:11 -0400
Date: Wed, 31 May 2006 02:00:09 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: David Miller <davem@davemloft.net>
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060531020009.A1868@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: David Miller <davem@davemloft.net>,
	draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060530235525.A30563@openss7.org> <20060531.001027.60486156.davem@davemloft.net> <20060531014540.A1319@openss7.org> <20060531.004953.91760903.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060531.004953.91760903.davem@davemloft.net>; from davem@davemloft.net on Wed, May 31, 2006 at 12:49:53AM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Wed, 31 May 2006, David Miller wrote:
> 
> For sure and there are plans afoot to move over to
> dynamic table sizing and the Jenkins hash function.

Yes, that could be far more efficient.

