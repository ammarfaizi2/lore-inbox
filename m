Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTGKPoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTGKPoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:44:07 -0400
Received: from smtp3.libero.it ([193.70.192.127]:47087 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S263894AbTGKPoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:44:04 -0400
Subject: Re: 2.5 'what to expect'
From: Flameeyes <daps_mls@libero.it>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030711140219.GB16433@suse.de>
References: <20030711140219.GB16433@suse.de>
Content-Type: text/plain
Message-Id: <1057939179.954.2.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 17:59:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 16:02, Dave Jones wrote:
> - (Possibly linked to above bug) VIA APIC routing is currently broken.
>   boot with 'noapic'.
On my system (with VIA KT266 chipset) I can't boot also using noapic
parameter, it freezes on "calibrating apic timer" using or not the
noapic parameter.
The only way is not enabling APIC at all.
-- 
Flameeyes <dgp85@users.sf.net>

