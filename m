Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVKKLJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVKKLJi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVKKLJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:09:38 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:62072 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750713AbVKKLJh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:09:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=tIdrz6rMVkfNRLcKx4Ypp782dpunndH4C6RMwqVljhQdHvDgpsfLGAG9kADCqoGPiFyXh4TB68KUZ9tWDYxtlwhpE3L47wIkamzJVG87MUxA/mdaccyzCMR+IusTp+Ul9JWQq6tN9wSB44OHJ50Ekov2YFrFHmnq+SdCanNw9WM=
Date: Fri, 11 Nov 2005 12:09:30 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: abonilla@linuxwireless.org, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rml@novell.com
Subject: Re: Kernel Panic 2.6.14-git (pictures)
Message-Id: <20051111120930.346b985a.diegocg@gmail.com>
In-Reply-To: <20051110175522.1d50c084.akpm@osdl.org>
References: <20051110151214.M35138@linuxwireless.org>
	<20051110175522.1d50c084.akpm@osdl.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 10 Nov 2005 17:55:22 -0800,
Andrew Morton <akpm@osdl.org> escribió:

> Yes, photos of the screen work very nicely, thanks.

So, it may be aceptable as "official method"?

--- stable/Documentation/oops-tracing.txt.old	2005-11-11 11:54:01.000000000 +0100
+++ stable/Documentation/oops-tracing.txt	2005-11-11 11:59:42.000000000 +0100
@@ -30,7 +30,9 @@ the disk is not available then you have 
 
 (1) Hand copy the text from the screen and type it in after the machine
     has restarted.  Messy but it is the only option if you have not
-    planned for a crash.
+    planned for a crash. Alternatively, you can take a picture of
+    the screen with a digital camera - not nice, but better than
+    nothing.
 
 (2) Boot with a serial console (see Documentation/serial-console.txt),
     run a null modem to a second machine and capture the output there
