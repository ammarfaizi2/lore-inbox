Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVDBEMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVDBEMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 23:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVDBEMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 23:12:38 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:13403 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262989AbVDBEMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 23:12:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=s9GAh1Bla7wOkTIEKDXL4/zyDoeRFpDnM+y4oajfplzMy4WpE7Mu4Gm/dQX01NJFk5xfjy6eVWjH8yXCyej+6I65zzy+4wNtJiTTSiKvz8ZWB1WOAsMi6zHCqJm1ivrT0RC0kXS4I+gCw5Bb/AF2atxSjv7n+fTPGXuDPMW5V6k=
Message-ID: <d160a820050401201225b52674@mail.gmail.com>
Date: Fri, 1 Apr 2005 23:12:35 -0500
From: Michael Freeman <mlfreeman@gmail.com>
Reply-To: Michael Freeman <mlfreeman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: LaCie Silverscreen Runs Linux, But No Source
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The LaCie Silverscreen external hard drive / media player contains a
~4 MByte ROMFS image that has a gzipped Linux kernel, Busybox, and a
few other assorted things.  However, LaCie makes no mention of using
GPLed software, nor do they offer any source code for download.  Has
anyone ever noticed this before (and, if so, what's the status on
source)?
You can download this firmware from
http://www.lacie.com/download/drivers/SilverScreen.zip -- the file
called romfs.bin is a plain romfs volume.  I successfully mounted it
using Knoppix and was able to browse the contents of the image.

Please CC me directly, because I'm not subscribed to this list. 

I apologize if this was discovered before, but my archive searches
found no reference.

(if I had the source, I'd probably buy one of these things).

--Michael L. Freeman
