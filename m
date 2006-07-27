Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWG0OHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWG0OHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWG0OHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:07:01 -0400
Received: from mail.visionpro.com ([63.91.95.13]:28333 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751329AbWG0OHA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:07:00 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Building the kernel on an SMP box?
Date: Thu, 27 Jul 2006 07:06:59 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Building the kernel on an SMP box?
Thread-Index: Acaxhe0jMnohAcVqQ+OjE+FbmkE5tA==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning all!

Currently I'm building my kernels on a Dell PE 1800 3.0GHz.  My dilemma
is that I build and rebuild the kernel about twenty times a day and even
though it only takes about 20 minutes, that's rapidly becoming too slow!
Today it's the 2.6.17 kernel on FC5 that I'm building with.

I see all these blurbs out there about someone being able to build a
complete kernel in under a minute or running an SMP build across
multiple CPUS and/or multiple machines.

So, to ask the group that should know the best ... What would be a
reasonable configuration to get my builds down under five minutes or so?
And then to go to the extreme, what kind of horsepower should I be
looking for if I want get the build times down to say a minute or so???

Thanks!

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

