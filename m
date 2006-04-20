Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWDTVYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWDTVYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWDTVYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:24:47 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:34215 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751320AbWDTVYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:24:47 -0400
Date: Fri, 21 Apr 2006 01:24:17 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
       Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060421012417.B16574@jurassic.park.msu.ru>
References: <20060419213129.GA9148@localhost> <20060419215803.6DE5BDBA1@gherkin.frus.com> <20060420101448.GA20087@localhost> <20060420171102.GA7272@localhost> <20060420205555.GA11502@bigip.bigip.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060420205555.GA11502@bigip.bigip.mine.nu>; from mchouque@free.fr on Thu, Apr 20, 2006 at 10:55:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 10:55:55PM +0200, Mathieu Chouquet-Stringer wrote:
> Same code compiled with 2.95.3 fails too (I'll be trying 4.1.0 just for
> the kick of it, if it cross-compiles ok but I don't expect it to work
> either).

Broken binutils, maybe?

Ivan.
