Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264740AbSIWDX2>; Sun, 22 Sep 2002 23:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIWDX2>; Sun, 22 Sep 2002 23:23:28 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64775
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264740AbSIWDX2>; Sun, 22 Sep 2002 23:23:28 -0400
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1032750261.3d8e84b5486a9@kolivas.net>
References: <1032750261.3d8e84b5486a9@kolivas.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 23:28:41 -0400
Message-Id: <1032751722.962.1009.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-22 at 23:04, Con Kolivas wrote:

> I performed contest benchmarks on kernel 2.5.38 when the kernel is compiled with
> gcc3.2 to gcc2.95.3
> 
> warning: The following benchmarks may be disturbing to some viewers:

Daniel Jacobowitz, a stunning gcc hacker, suggests you retry with
gcc-3.2 from CVS.  Apparently some fixes have gone in since 3.2 release.

If the problem still occurs, there is either a serious problem in gcc or
we have some code that is miscompiled by gcc-3.2 (perhaps not its fault
but the kernel's).

	Robert Love

