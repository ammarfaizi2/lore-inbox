Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbTFLFRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 01:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbTFLFRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 01:17:03 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:5445 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264736AbTFLFRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 01:17:01 -0400
Date: Wed, 11 Jun 2003 22:31:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jordan Breeding <jordan.breeding@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm8
Message-Id: <20030611223142.0e5ac956.akpm@digeo.com>
In-Reply-To: <3EE80D89.6020805@sbcglobal.net>
References: <20030611013325.355a6184.akpm@digeo.com>
	<3EE80D89.6020805@sbcglobal.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 05:30:46.0108 (UTC) FILETIME=[C64A81C0:01C330A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding <jordan.breeding@sbcglobal.net> wrote:
>
>  Then I tried backing out pci-init-ordering-fix.patch and 
>  that did the trick.

Yeah, that experiment will be terminated.  It fixed two machines and broke
three.


>  when will the elevator selection messages either go 
>  away or get limited to a couple of times per boot.

umm, in about five minutes time?

