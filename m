Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbUKRGbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbUKRGbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUKRGbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:31:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:939 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262615AbUKRGad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:30:33 -0500
Date: Thu, 18 Nov 2004 01:30:09 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2-mm1 - detect-atomic-counter-underflows.patch
In-Reply-To: <200411171803.iAHI3wIG018055@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.44.0411180128570.2938-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 Valdis.Kletnieks@vt.edu wrote:

> Now, I *may* have simply shot myself in the foot, but when I tried booting
> 2.6.10-rc2-mm1, I got spewed *thousands* of messages triggered by this:

Are you running SELinux?

Try this: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=110062417701884&w=2



- James
-- 
James Morris
<jmorris@redhat.com>


