Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTKKXh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTKKXh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:37:56 -0500
Received: from broremann2.ux.his.no ([152.94.1.11]:48855 "EHLO
	broremann2.ux.his.no") by vger.kernel.org with ESMTP
	id S263810AbTKKXhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:37:55 -0500
Date: Wed, 12 Nov 2003 00:37:51 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-ID: <20031111233751.GA17514@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
References: <BF1FE1855350A0479097B3A0D2A80EE0013B1188@hdsmsx402.hd.intel.com> <1068580528.26160.12.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1068580528.26160.12.camel@dhcppc4>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a bit OT in this thread but...
Doesn't the information in /proc/interrupts really belong somewhere in sysfs?

Regards
	Erlend Aasland
