Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTKVCum (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 21:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTKVCum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 21:50:42 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:4062 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S261838AbTKVCul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 21:50:41 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: The plug and play menu is ISA only?
Date: Fri, 21 Nov 2003 20:41:22 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311212041.22604.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the "plug and play" menu just ISA plug and play only?  (It has nothing to 
do with hotplug or anything else, right?  PCI devices are "plug and play", 
but that's an actual part of the PCI spec.  USB is hotplug and play, etc.)

Or is this also used for on-motherboard devices in modern systems?  (Is it 
ever likely to be needed on a laptop made in the last five years, for 
eample?)

Rob
