Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTFLScP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTFLScO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:32:14 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43389 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264938AbTFLSbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:31:39 -0400
Date: Thu, 12 Jun 2003 14:45:22 -0400
From: Bill Nottingham <notting@redhat.com>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M (Centrino) cpufreq device driver (please test me)
Message-ID: <20030612144521.A19228@devserv.devel.redhat.com>
Mail-Followup-To: Anders Karlsson <anders@trudheim.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1055371846.4071.52.camel@localhost.localdomain> <1055406614.2551.6.camel@tor.trudheim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1055406614.2551.6.camel@tor.trudheim.com>; from anders@trudheim.com on Thu, Jun 12, 2003 at 09:30:14AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Karlsson (anders@trudheim.com) said: 
> On Wed, 2003-06-11 at 23:50, Jeremy Fitzhardinge wrote:
> > This is the latest version of my Enhanced SpeedStep driver for cpufreq. 
> > It supports current Pentium M CPUs.
> 
> Can this be rebased against 2.4.21 and be included in 2.4.22-pre please?
> :-)

http://people.redhat.com/notting/cpufreq-centrino.patch

Rebased against something vaguely 2.4.21-pre-ish.

Bill
