Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVDTHc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDTHc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 03:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVDTHcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 03:32:25 -0400
Received: from gate.firmix.at ([80.109.18.208]:30905 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261253AbVDTHcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 03:32:00 -0400
Subject: Re: GPL violation by CorAccess?
From: Bernd Petrovitsch <bernd@firmix.at>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-os@analogic.com, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42659620.5050002@nortel.com>
References: <20050419175743.GA8339@beton.cybernet.src>
	 <20050419182529.GT17865@csclub.uwaterloo.ca>
	 <Pine.LNX.4.61.0504191516080.18402@chaos.analogic.com>
	 <42656319.6090703@nortel.com>
	 <Pine.LNX.4.61.0504191741190.19956@chaos.analogic.com>
	 <42659620.5050002@nortel.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Wed, 20 Apr 2005 09:30:08 +0200
Message-Id: <1113982209.3803.7.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-19 at 17:37 -0600, Chris Friesen wrote:
> Richard B. Johnson wrote:
> 
> > No. Accompany it with a written offer to __provide__ the source
> > code for any GPL stuff they used (like the kernel or drivers).
> > Anything at the application-level is NOT covered by the GPL.

That depends on the software used there.

> > They do not have to give away their trade-secrets.

Unless they coded them into GPL software ...

> GPL'd applications would still be covered by the GPL, no?

Good question: Strictly speaking if you omit the GPL in the delivered
ssoftware/product/whatever, you violated the GPL yourself and - thus -
loose all rights which are "given" to you through the GPL.

> If I buy their product, I should be able to ask them for the source to 
> all GPL'd entities that are present in the system, including the kernel, 
> drivers, and all GPL'd userspace apps.

ACK.

> Any *new* apps that they wrote they would of course be free to keep private.

As long as they do not statically link against LGPL (or GPL) code and as
long as they do not link dynamically agaist GPL code. And there are
probably more rules .....

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



