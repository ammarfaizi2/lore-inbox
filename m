Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTICW7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTICW7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:59:47 -0400
Received: from main.gmane.org ([80.91.224.249]:8926 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264290AbTICW7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:59:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Wes Felter" <wesley@felter.org>
Subject: Re: Remote SCSI Emulation
Date: Wed, 03 Sep 2003 22:59:33 +0000
Message-ID: <pan.2003.09.03.22.59.26.698967@felter.org>
References: <LAW11-F717fcGuKeddZ000021c9@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 20:38:14 +0000, Muthian S wrote:

> Certain SCSI adapters like the Adaptec AHA 29160 are reportedly capable of
> acting as a target and can receive SCSI commands from initiators.  Such an
> adapter can be used to facilitate remote SCSI emulation by a PC.
> For instance, if two PCs have the adapter, the two adapters can be
> directly connected by a SCSI bus and the second PC can in effect serve as
> an "emulated SCSI disk".  Such a setup is extremely helpful in various
> scenarios.

Search the archives/Web for "SCSI target", "LinuxDisk", etc. There are
plenty of half-finished implementations of this.

-- 
Wes Felter - wesley@felter.org - http://felter.org/wesley/


