Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTENQ4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTENQ4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:56:23 -0400
Received: from palrel10.hp.com ([156.153.255.245]:11403 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262303AbTENQ4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:56:22 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16066.30766.864609.953202@napali.hpl.hp.com>
Date: Wed, 14 May 2003 10:09:02 -0700
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: davidm@hpl.hp.com, "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
In-Reply-To: <20030514134141.A5170@jurassic.park.msu.ru>
References: <1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
	<16064.453.497373.127754@napali.hpl.hp.com>
	<1052774487.10750.294.camel@thor>
	<16064.5964.342357.501507@napali.hpl.hp.com>
	<1052786080.10763.310.camel@thor>
	<16064.17852.647605.663544@napali.hpl.hp.com>
	<20030513173347.A25865@jurassic.park.msu.ru>
	<16065.6969.137647.391163@napali.hpl.hp.com>
	<20030514134141.A5170@jurassic.park.msu.ru>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 14 May 2003 13:41:41 +0400, Ivan Kokshaysky <ink@jurassic.park.msu.ru> said:

  >> What's the nature of those "ugly and fragile" hacks?  Are you saying
  >> that CPU accesses to AGP space aren't remapped in the "normal" (PC)
  >> way?  Or is it something entirely different?

  Ivan> Ok, you asked for it... :-)

My golly, I don't envy you!

	--david
