Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUCCXwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUCCXwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:52:34 -0500
Received: from amdext.amd.com ([139.95.251.1]:24475 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id S261245AbUCCXwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:52:33 -0500
Message-ID: <99F2150714F93F448942F9A9F112634C109A392F@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: pavel@suse.cz, davej@redhat.com, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org, davej@codemonkey.ork.uk
Subject: RE: powernow-k8-acpi driver
Date: Wed, 3 Mar 2004 17:48:46 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C58B166347408-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> you're aware of Dominik/Bruno's work on the 'acpilib'[1] stuff in this 
>> area right ? We'll need that anyway for Powernow-k7 and maybe longhaul 
>> too and its senseless duplicating this code.
> 
> That [1] looks like promise of url, but I don't see that url.

No, I am not aware of this, and I think Dominik is out for a few days.
If there is some sort of library functionality I can use and eliminate
code in the powernow-k8 driver, I will glad make the change to use it.

Paul.

