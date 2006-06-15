Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030648AbWFORFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030648AbWFORFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 13:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030841AbWFORFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 13:05:35 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:9414 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030648AbWFORFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 13:05:34 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC4
From: Keith Owens <kaos@ocs.com.au>
To: "jdow" <jdow@earthlink.net>
cc: "Jesper Juhl" <jesper.juhl@gmail.com>, nick@linicks.net,
       "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Bernd Petrovitsch" <bernd@firmix.at>,
       "marty fouts" <mf.danger@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter) 
In-reply-to: Your message of "Mon, 12 Jun 2006 16:03:46 MST."
             <027e01c68e74$76875910$0225a8c0@Wednesday> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Jun 2006 03:05:18 +1000
Message-ID: <30592.1150391118@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"jdow" (on Mon, 12 Jun 2006 16:03:46 -0700) wrote:
>Greylist those who have not subscribed. Let their email server try
>again in 30 minutes. For those who are not subscribed it should not
>matter if their message is delayed 30 minutes. And so far spammers
>never try again.

Not true.  I greylist and my recent logs show a pattern of spam code
that tries 5 times at exactly 5 minute intervals, before finally giving
up.  Other spam code tries two or three times at one hour intervals.
All designed by spammers to bypass greylist systems.

