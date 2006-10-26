Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423140AbWJZKXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423140AbWJZKXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423141AbWJZKXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:23:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:12416 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1423140AbWJZKXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:23:04 -0400
Date: Thu, 26 Oct 2006 12:22:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux@horizon.com
cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2 and very unstable NTP
In-Reply-To: <20061026100027.32164.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0610261218350.6761@scrub.home>
References: <20061026100027.32164.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Oct 2006, linux@horizon.com wrote:

> > Please specify "+ linuxpps".
> 
> http://gitweb.enneenne.com/?p=linuxpps;a=summary
> http://wiki.enneenne.com/index.php/LinuxPPS_support
> 
> It's a PPS-input timestamping driver, touching drivers/serial/8250.c
> and the like.  No contact with kernel timekeeping code, other than
> calling it to obtain the timestamps.

Did you ask the author? It would really help to have more specific 
information here, e.g. what kernel interfaces are actually used in this 
configuration.

bye, Roman
