Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWDTV0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWDTV0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWDTV0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:26:35 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:65206 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S1751323AbWDTV0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:26:34 -0400
X-ME-UUID: 20060420212633721.B035D7000095@mwinf1308.wanadoo.fr
Date: Thu, 20 Apr 2006 23:25:32 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060420212532.GA7117@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
References: <20060419213129.GA9148@localhost> <20060419215803.6DE5BDBA1@gherkin.frus.com> <20060420101448.GA20087@localhost> <20060420171102.GA7272@localhost> <20060421012227.A16574@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421012227.A16574@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 01:22:27AM +0400, Ivan Kokshaysky wrote:
> I'm unable to reproduce this with the toolchains that I have.

Ha, that's good news: which versions?

-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

