Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936374AbWLFQcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936374AbWLFQcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936399AbWLFQcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:32:47 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:41980 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936374AbWLFQcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:32:47 -0500
Message-ID: <4576F0AD.2010306@s5r6.in-berlin.de>
Date: Wed, 06 Dec 2006 17:32:45 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
       =?ISO-8859-1?Q?Kristian_H=F8?= =?ISO-8859-1?Q?gsberg?= 
	<krh@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <1165308400.2756.2.camel@localhost>  <45758CB3.80701@redhat.com> <1165332650.2756.27.camel@localhost> <Pine.LNX.4.62.0612061720390.28483@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0612061720390.28483@pademelon.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Tue, 5 Dec 2006, Marcel Holtmann wrote:
>> I personally would go with
>> "ieee1394", because that is the official name for it. Otherwise go with
>> "firewire" if you wanna separate yourself from the previous stack.
> 
> Which still leaves the opportunity for having a third stack in drivers/ilink
> :-)

Wait for the real one, to appear in drivers/high_performance_serial_bus.
-- 
Stefan Richter
-=====-=-==- ==-- --==-
http://arcgraph.de/sr/
