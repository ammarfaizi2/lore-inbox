Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTKVDuG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 22:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTKVDuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 22:50:06 -0500
Received: from main.gmane.org ([80.91.224.249]:55503 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261841AbTKVDuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 22:50:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: The plug and play menu is ISA only?
Date: Sat, 22 Nov 2003 04:49:59 +0100
Message-ID: <yw1xhe0xcba0.fsf@kth.se>
References: <200311212041.22604.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:P3+k5zKntdsXrsf9a/gmikHR+Zs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> Is the "plug and play" menu just ISA plug and play only?  (It has nothing to 
> do with hotplug or anything else, right?  PCI devices are "plug and play", 
> but that's an actual part of the PCI spec.  USB is hotplug and play, etc.)
>
> Or is this also used for on-motherboard devices in modern systems?  (Is it 
> ever likely to be needed on a laptop made in the last five years, for 
> eample?)

The only time you ever need to select ISA plug and play, is if you
have an old PnP ISA card.  You'd know if you did.  Modern systems
don't even have ISA slots.

-- 
Måns Rullgård
mru@kth.se

