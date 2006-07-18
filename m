Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWGRWFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWGRWFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWGRWFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:05:22 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:20385 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932088AbWGRWFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:05:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: George Nychis <gnychis@cmu.edu>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Date: Wed, 19 Jul 2006 00:05:02 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Chua <jchua@fedex.com>, lkml <linux-kernel@vger.kernel.org>
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <44BCFDA6.3030909@cmu.edu>
In-Reply-To: <44BCFDA6.3030909@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607190005.02351.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 July 2006 17:26, George Nychis wrote:
> acpid has been started, however there is no /sys/power/disk

Have you set CONFIG_SOFTWARE_SUSPEND in .config?

Rafael
