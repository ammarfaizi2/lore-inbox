Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWJEA3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWJEA3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWJEA3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:29:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:61914 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751262AbWJEA3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:29:36 -0400
From: Andi Kleen <ak@suse.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: DWARF2 unwinder stuck
Date: Thu, 5 Oct 2006 02:28:46 +0200
User-Agent: KMail/1.9.3
Cc: Jiri Kosina <jikos@jikos.cz>, linux-kernel@vger.kernel.org
References: <200610050004.k9504IpO022761@laptop13.inf.utfsm.cl>
In-Reply-To: <200610050004.k9504IpO022761@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610050228.46574.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 02:04, Horst H. von Brand wrote:
> Jiri Kosina <jikos@jikos.cz> wrote:
> > Hi Andi,
> > 
> > I know you are hunting all the DWARF2 unwinding stucks. I have just got 
> > the one below, when debuging kernel panic in MPU401 driver, with Linus' 
> > current git tree.
> 
> OK, if somebody is collecting these beasts...

I'm only interested in reports from recent git.
> 
> Loading the ipw3945-1.1.0 driver I get with Fedora rawhide's
> 2.6.18-1.2726.fc6 on a Centrino duo:

This is too old.

-Andi

