Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270740AbTHFQrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270817AbTHFQrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:47:23 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:60935 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270740AbTHFQpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:45:31 -0400
Subject: Re: TSCs are a no-no on i386
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 06 Aug 2003 09:45:33 -0700
Message-Id: <1060188334.2629.5.camel@fuzzy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And I think the i82489DX APIC was introduced a bit later
> anyway -- we don't support non-APIC SMP implementations. 

Actually, we do in 2.6 for 486, 586 and PPro.

James


