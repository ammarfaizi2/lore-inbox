Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbTFMVkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbTFMVkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:40:07 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:35292 "EHLO minime.uib.es")
	by vger.kernel.org with ESMTP id S265543AbTFMVga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:36:30 -0400
From: Ricardo Galli <gallir@uib.es>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released  (acpi)
Date: Fri, 13 Jun 2003 23:49:20 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306132349.22072.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you don't like it, just disable it. For lots of other people with new 
> laptops the latest ACPI is mandatory.
...
>> For me acpid is not workin well. When I use acpid on ECS_L7VTA-00-C (BIOS-1.6)
>> the network card (integrated with main borad) is not working, DHCPd client is
>> time outing and there is no routing via that hardware ;-)
 
Not for Dell Latitude (X200), no battery detected, no suspend, button doesn't
shutdown nicely (it just switches the machine off). So, still surviving with APM, 
even in 2.5.70.

And, yes, I already reported several times since 2.5.68 and 2.4.21-rc2-acX

But I vote for XFS.

-- 
  ricardo

