Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUGCLm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUGCLm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 07:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUGCLm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 07:42:58 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:40377 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264931AbUGCLm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 07:42:57 -0400
Date: Sat, 3 Jul 2004 12:39:01 +0100
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, limaunion@fibertel.com.ar,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk,
       water modem <lundby@ameritech.net>
Subject: Re: [patch] Re: 2.6.7-mm2 build errors...
Message-ID: <20040703113901.GO7101@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@fs.tum.de>, "Randy.Dunlap" <rddunlap@osdl.org>,
	limaunion@fibertel.com.ar, linux-kernel@vger.kernel.org,
	cpufreq@www.linux.org.uk, water modem <lundby@ameritech.net>
References: <40DCEFFB.5020605@fibertel.com.ar> <20040702205129.GK28324@fs.tum.de> <20040702140322.2ab47867.rddunlap@osdl.org> <20040702215024.GL28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702215024.GL28324@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 11:50:24PM +0200, Adrian Bunk wrote:

 > > but my patch was insufficient:
 > > http://marc.theaimsgroup.com/?l=linux-kernel&m=108753512102539&w=2
 > > 
 > > See reply from Dave Jones.  And I see what he means, but I don't
 > > see how to express it in Kconfig language.
 > 
 > What about the patch below?

Looks good, I'll give it a test later, and roll it into cpufreq-bk
and let it simmer in -mm for a few days.  (There's a bunch of other
cpufreq bits that have backlogged which I also need to get some
testing of).

		Dave

