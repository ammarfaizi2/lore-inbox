Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTDMMSC (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbTDMMSC (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:18:02 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:11393
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S263481AbTDMMSB (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 08:18:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: >=2.5.66 compiling errors on Alpha
References: <3E98117F.8090705@g-house.de>
	<1050213058.15082.0.camel@rth.ninka.net>
	<yw1xfzomd6an.fsf@zaphod.guide>
	<wrpfzomy6h3.fsf@hina.wild-wind.fr.eu.org>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 13 Apr 2003 14:30:16 +0200
In-Reply-To: <wrpfzomy6h3.fsf@hina.wild-wind.fr.eu.org>
Message-ID: <yw1xy92ebmw7.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <mzyngier@freesurf.fr> writes:

> Måns> That won't work.  There have been two (equivalent) patches
> Måns> posted to this list recently.  Will someone pick them up?
> 
> Looks like Ivan Kokshaysky is opposed to this approach (see the
> discussion that happended on axp-list last week about the same patch I
> posted to both axp-list and lkml).

It's strange that this is bad on Alpha, but ok for all other machines.
Whatever the reason, it would be nice to have a fix in 2.5.68.

-- 
Måns Rullgård
mru@users.sf.net
