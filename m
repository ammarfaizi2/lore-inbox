Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbVIPB6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbVIPB6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 21:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbVIPB6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 21:58:30 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:6309 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161046AbVIPB6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 21:58:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Date: Thu, 15 Sep 2005 20:58:23 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050916002036.GA6149@suse.de> <200509151958.45573.dtor_core@ameritech.net> <20050916014652.GA12920@vrfy.org>
In-Reply-To: <20050916014652.GA12920@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509152058.23759.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 20:46, Kay Sievers wrote:
> 
> I would like to have the option to move "block" into "class" some day
> and therefore prefer the "stacking class devices", compared to the "grouping
> and symlinking" classes model.
> 

The question is why can't we have both models? I agree that for block
you want what Greg is proposing, for input and some other subsystems
- not so much.

-- 
Dmitry
