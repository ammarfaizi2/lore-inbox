Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUIANAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUIANAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUIANAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:00:37 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:49069 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266366AbUIANAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:00:35 -0400
Date: Wed, 1 Sep 2004 14:00:11 +0100
From: Dave Jones <davej@redhat.com>
To: Romain Moyne <aero_climb@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
Message-ID: <20040901130011.GB10829@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Romain Moyne <aero_climb@yahoo.fr>, linux-kernel@vger.kernel.org
References: <200409021453.09730.aero_climb@yahoo.fr> <200409021614.10377.aero_climb@yahoo.fr> <Pine.LNX.4.58.0409010835050.4481@montezuma.fsmlabs.com> <200409021708.31410.aero_climb@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409021708.31410.aero_climb@yahoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 05:08:30PM +0200, Romain Moyne wrote:
 > >Do you have files in /sys/devices/system/cpu/cpu0/cpufreq ?
 > I don't.

what about after modprobe powernow-k8 ?
(that should also print out some messages in dmesg)

		Dave

