Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVF1GkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVF1GkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVF1GjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:39:25 -0400
Received: from [213.184.188.19] ([213.184.188.19]:7172 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S262017AbVF1Ghx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:37:53 -0400
Message-Id: <200506280637.JAA07324@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: linux 2.6.12 and IOWAIT
Date: Tue, 28 Jun 2005 09:37:33 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050627214016.2046e29e.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV7m3E+HQ/2czqOSi2jGar/CxlyfgADHUJw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Arendt <admin@prnet.org> wrote:
>
> I have to following problem using kernel 2.6.12: IOWAIT is always at 
> 100% in top, the system seems to be significally slower. Any idea what 
> could lead to this ?

It's true, 2.6.12 is about 20% slower than 2.4.31 during a make bzlilo and I
suspect IOWAIT.

