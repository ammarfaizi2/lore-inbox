Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTFQSha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTFQSh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:37:29 -0400
Received: from main.gmane.org ([80.91.224.249]:21430 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264880AbTFQSh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:37:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.5.71 compile error on alpha
Date: 17 Jun 2003 20:26:35 +0200
Message-ID: <yw1xk7bk36hw.fsf@zaphod.guide>
References: <3EEE4A14.4090505@g-house.de> <wrpr85te3fa.fsf@hina.wild-wind.fr.eu.org> <3EEF585E.9030404@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> writes:

> oh, just before vmlinux was made! before & after applying the patch i
> did "make clean" (do i have to make clean "before" applying patches
> anyway? after applying patches and before making targets, yes.)

I don't think so.

> oh, and this alpha is named "Avanti" but a kernel compile needs 80mins
> or so :-)

That's typical for the slower Avantis.  Is your's something like 100 MHz?

-- 
Måns Rullgård
mru@users.sf.net

