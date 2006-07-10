Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWGJNNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWGJNNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGJNNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:13:09 -0400
Received: from outbound3.mail.tds.net ([216.170.230.93]:55502 "EHLO
	outbound3.mail.tds.net") by vger.kernel.org with ESMTP
	id S964789AbWGJNNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:13:08 -0400
Date: Mon, 10 Jul 2006 08:13:05 -0500 (CDT)
From: David Lloyd <dmlloyd@flurg.com>
To: Bojan Smojver <bojan@rexursive.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Intel ICH7 82801GBM/GHM
In-Reply-To: <20060710132702.zybmjie9co8wk440@www.rexursive.com>
Message-ID: <Pine.LNX.4.64.0607100812300.29439@ultros>
References: <20060710132702.zybmjie9co8wk440@www.rexursive.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Bojan Smojver wrote:

> Does anyone know if this chip, which goes by PCI ID 8086:27c4 (as listed 
> in ata_piix.c) is something that ahci.c can also drive? It isn't listed 
> explicity in ahci.c file, but ata_piix.c file says it's identical to 
> ICH6M, which is listed in ahci.c.

See this link, which lists all the Intel controllers that are AHCI:

http://www.intel.com/support/chipsets/imst/sb/CS-012304.htm

- DML
