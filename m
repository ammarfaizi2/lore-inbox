Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUHCHvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUHCHvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUHCHvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:51:47 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27328 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265134AbUHCHvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:51:46 -0400
Date: Tue, 3 Aug 2004 09:48:42 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bart Alewijnse <scarfboy@gmail.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: gigabit trouble
Message-ID: <20040803094842.B4911@electric-eye.fr.zoreil.com>
References: <20040729210401.A32456@electric-eye.fr.zoreil.com> <b71082d80407291541f9d6f93@mail.gmail.com> <b71082d804073008157cf1d6c0@mail.gmail.com> <20040730205412.A15669@electric-eye.fr.zoreil.com> <b71082d804073014037bc5dd5a@mail.gmail.com> <20040730234120.A15536@electric-eye.fr.zoreil.com> <b71082d804073112512bbd82e2@mail.gmail.com> <20040731231836.A31121@electric-eye.fr.zoreil.com> <b71082d804080112031621e041@mail.gmail.com> <b71082d804080219476103bd47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b71082d804080219476103bd47@mail.gmail.com>; from scarfboy@gmail.com on Tue, Aug 03, 2004 at 04:47:43AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Alewijnse <scarfboy@gmail.com> :
[...]
> The panic looks a lot like the last one; same kernel (napi still
> enabled for the 8169). Image attached.

The irq rate are strangely high for a napi version of the r8169 driver.

Can you describe your test commands so that I reproduce these here ?

--
Ueimor
