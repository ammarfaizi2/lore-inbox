Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbTFMVpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbTFMVmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:42:15 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:52454 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S265546AbTFMVl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:41:27 -0400
Date: Fri, 13 Jun 2003 22:55:15 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: hanno@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc8-laptop1 released
Message-ID: <20030613215515.GA9940@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Brad Chapman <jabiru_croc@yahoo.com>, hanno@gmx.de,
	linux-kernel@vger.kernel.org
References: <20030613011315.50941.qmail@web40017.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613011315.50941.qmail@web40017.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 06:13:15PM -0700, Brad Chapman wrote:
 > If you could backport 2.5 cpufreq and add it to this patchset
 > I would start using it too. My biggest grab is the updated DRM,
 > but cpufreq would be a huge help as well.

Dominik did a speedy backport to current 2.4.
You can find them at http://www.codemonkey.org.uk/cpufreq/

There's patches there for mainline and -ac, so should apply
to whatever other patchset you choose to use, at worse there'll
be trivial-to-fix-up rejects.

This backport also contains Jeremy's Centrino-speedstep driver.

		Dave

