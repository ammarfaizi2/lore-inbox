Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbTFLMWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTFLMWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:22:38 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:11682 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264639AbTFLMWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:22:36 -0400
Date: Thu, 12 Jun 2003 13:36:04 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Yaroslav Rastrigin <yarick@relex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPUFreq (SpeedStep) support for Intel PIII (Coppermine) and PIIX4 ?
Message-ID: <20030612123604.GA7600@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Yaroslav Rastrigin <yarick@relex.ru>, linux-kernel@vger.kernel.org
References: <200306121430.01664.yarick@relex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306121430.01664.yarick@relex.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 02:30:01PM +0400, Yaroslav Rastrigin wrote:

 > Is there any plans to support aforementioned combination ? I've seen remarks 
 > in driver sources about unavailability of (sufficient) documentation for this 
 > chipset - does it means SpeedStep for IBM T20/21 series of laptops will not 
 > be available ? Or, maybe, some progress is already underway ? How could I 
 > help ? 

There's been some noise about it on the cpufreq list, and an example
driver that works for some people, but not all. It's getting there, slowly.
If you want to know more, I suggest you join the list, and volunteer as
a test bunny.

		Dave

