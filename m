Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVGUXbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVGUXbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 19:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGUXbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 19:31:04 -0400
Received: from cfa.harvard.edu ([131.142.10.1]:33232 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S261891AbVGUXbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 19:31:03 -0400
Date: Thu, 21 Jul 2005 19:31:02 -0400 (EDT)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: linux-kernel@vger.kernel.org
Subject: kernel page size explanation
Message-ID: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for this nursery-school question.

Could someone briefly explain me :
1. what is the kernel page size (any _useful_ pointer on the web is fine),
2. how can one tune it (for 2.6.*)?
3. what kind of effect does it have on system performance, if it is
tuneable, and if it worth changing this at all?

I am a bit confused; at one place i see someone saying that the kernel
page size is 4kb for i386.
At another place I see a statement:
"I tried all four possible page sizes on Itanium (4k, 8k, 16k and 64k)"

How can i figure out the page size of the kernel i am currently using?

Cheers
Gaspar
