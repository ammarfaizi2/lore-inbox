Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422812AbWJOTYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbWJOTYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWJOTYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:24:25 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:31666 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1422812AbWJOTYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:24:25 -0400
Date: Sun, 15 Oct 2006 21:24:23 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: privilege levels and kernel mode
Message-ID: <20061015192423.GA22346@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610151141280.3952@g5.osdl.org> <20061015191716.15283.qmail@web27401.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015191716.15283.qmail@web27401.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 08:17:16PM +0100, ranjith kumar wrote:

> memory reads, number of cache misses occured while
> running  a "C" program. For that I have to wright some
> values into "Model specific registers of pentium-4
> processor". But those registers can be written ONLY at
> privilege level of zero of pentium4 processor.

Look at 'perfmon' and 'perfctr', they give you what you want.


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
