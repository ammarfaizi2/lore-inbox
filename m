Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbTINTL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 15:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTINTL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 15:11:57 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:1808
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261272AbTINTL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 15:11:56 -0400
Subject: Re: 1:1 M:N threading
From: Robert Love <rml@tech9.net>
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <000b01c37af0$402349a0$f8e4a7c8@bsb.virtua.com.br>
References: <000b01c37af0$402349a0$f8e4a7c8@bsb.virtua.com.br>
Content-Type: text/plain
Message-Id: <1063566718.24473.63.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sun, 14 Sep 2003 15:11:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-14 at 14:44, Breno wrote:

> What kind of threading kernel 2.4 and 2.6 do ? 1:1 or M:N ?

Both do 1:1.

But nothing stops you from running an M:1 or M:N threading library in
user-space on top of the kernel abstraction.

	Robert Love


