Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269702AbUJMNe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269702AbUJMNe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 09:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269703AbUJMNe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 09:34:28 -0400
Received: from mx2.magma.ca ([206.191.0.250]:37343 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S269702AbUJMNe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 09:34:27 -0400
Subject: Re: 2.6.9-rc4-mm1
From: Jesse Stockall <stockall@magma.ca>
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <87r7o23gdu.fsf@barad-dur.crans.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
	 <1097672832.5500.60.camel@homer.blizzard.org>
	 <87r7o23gdu.fsf@barad-dur.crans.org>
Content-Type: text/plain
Message-Id: <1097674487.5500.62.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 09:34:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 09:19, Mathieu Segaud wrote:
> 
> here's a fix
> cd /usr/src/linux-2.6.9-rc4-mm1
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
> patch -R -p1 < optimize-profile-path-slightly.patch
> 
> this should fix the sources and so...

Yup, that fixed it.

Thanks

-- 
Jesse Stockall <stockall@magma.ca>

