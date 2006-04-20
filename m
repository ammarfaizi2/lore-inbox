Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWDTV1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWDTV1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWDTV1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:27:48 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:2614 "EHLO smtp10.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751327AbWDTV1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:27:47 -0400
X-ME-UUID: 20060420212746105.19AFA3000089@mwinf1006.wanadoo.fr
Date: Thu, 20 Apr 2006 23:27:45 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060420212745.GB7117@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, rth@twiddle.net
References: <20060419213129.GA9148@localhost> <20060419215803.6DE5BDBA1@gherkin.frus.com> <20060420101448.GA20087@localhost> <20060420171102.GA7272@localhost> <20060420205555.GA11502@bigip.bigip.mine.nu> <20060421012417.B16574@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421012417.B16574@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 01:24:17AM +0400, Ivan Kokshaysky wrote:
> Broken binutils, maybe?

2.15.92.0.2 and 2.15 (cross compiled) fail.  What's yours?

-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

