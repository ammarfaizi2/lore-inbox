Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbUFKPOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUFKPOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUFKPOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:14:45 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:39344 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S264044AbUFKPOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:14:44 -0400
Message-ID: <40C9CC65.5030209@metaparadigm.com>
Date: Fri, 11 Jun 2004 23:14:45 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040528 Debian/1.6-7
X-Accept-Language: en
MIME-Version: 1.0
To: Aubin LaBrosse <arl8778@rit.edu>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PPC]  2.6.7-rc3 IBM405EP kernel won't build without PCI
References: <1086930832.8686.50.camel@lhosts>
In-Reply-To: <1086930832.8686.50.camel@lhosts>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/04 21:13, Aubin LaBrosse wrote:
> Hello all,
> 
> I'm having a little fun with my first embedded system - it's an
> Intrinsyc CerfCube, http://www.intrinsyc.com/products/cerfcube405EP/
> 
> basically it's got an ibm 405ep powerpc processor in it.  the thing
> ships with a version of 2.4.21 but i've decided to take the newer
> kernels for a spin on it.  except i can't compile unless i enable pci,
> which is unnecessary for this thing since it has no pci bus.

Then why does it have a miniPCI connector?

~mc
