Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVHCLAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVHCLAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVHCLAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:00:52 -0400
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:5545 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262211AbVHCK7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:59:12 -0400
From: Jan De Luyck <lkml@kcore.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.13-rc5 - possible acpi regression?
Date: Wed, 3 Aug 2005 12:59:16 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <200508020843.08030.lkml@kcore.org> <200508021250.39136.rjw@sisk.pl>
In-Reply-To: <200508021250.39136.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508031259.17172.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 August 2005 12:50, Rafael J. Wysocki wrote:
> Please try to ad the ec_polling parameter to the kernel command line and
> retest.

That helps a lot. Thanks, it's back to the 'old way'.

Jan
-- 
...Deep Hack Mode -- that mysterious and frightening state of
consciousness where Mortal Users fear to tread.
	-- Matt Welsh
