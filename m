Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTKKIfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 03:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTKKIfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 03:35:46 -0500
Received: from zork.zork.net ([64.81.246.102]:27305 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263415AbTKKIfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 03:35:45 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Fibre channel HBA support
References: <HBEHKOEIIJKNLNAMLGAOAEDDDKAA.info@avistor.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 11 Nov 2003 08:35:43 +0000
In-Reply-To: <HBEHKOEIIJKNLNAMLGAOAEDDDKAA.info@avistor.com> (Joseph
 Shamash's message of "Mon, 10 Nov 2003 19:27:47 -0800")
Message-ID: <6u4qxb8fq8.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joseph Shamash" <info@avistor.com> writes:

> I have been searching for information on fibre channel HBA support for the
> 2.6.0 kernel. I was hoping to use the LSIFC919, but my search seems to
> indicate this driver is not yet supported in the 2.6.0 kernel.
>
> I did find the HP Fibre Channel HBA is supported. Can anyone please advise
> me about any other Fibre Channel HBA support in the 2.6.0 kernel?

A driver for Emulex Fibre Channel HBAs showed up recently in Martin J.
Bligh's tree, although my cursory search did not turn up a broken-out
set of patches.

http://sourceforge.net/mailarchive/forum.php?thread_id=3424272&forum_id=5292

