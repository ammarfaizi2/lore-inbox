Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271226AbTGWTLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271231AbTGWTHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:07:19 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:21418 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S271233AbTGWTFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:05:46 -0400
Date: Wed, 23 Jul 2003 20:20:10 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test1-ac3
Message-ID: <20030723192010.GA28748@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200307231910.h6NJAHg02616@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307231910.h6NJAHg02616@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 03:10:17PM -0400, Alan Cox wrote:
 > o	Fix delay setup in speedstep-ich		(Valdis Kletnieks)

Don't push this Linuswards, Dominik sent me a better set of
fixes which are sitting in the cpufreq tree awaiting pushing
when I get back from KS/OLS.

		Dave

