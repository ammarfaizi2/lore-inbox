Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131071AbRA2Smo>; Mon, 29 Jan 2001 13:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbRA2Sme>; Mon, 29 Jan 2001 13:42:34 -0500
Received: from [212.6.145.2] ([212.6.145.2]:61961 "HELO heaven.astaro.de")
	by vger.kernel.org with SMTP id <S129710AbRA2SmR>;
	Mon, 29 Jan 2001 13:42:17 -0500
Message-ID: <3A75B96A.611B39C3@astaro.de>
Date: Mon, 29 Jan 2001 19:41:46 +0100
From: Dennis Koslowski <dennis.koslowski@astaro.de>
Organization: astaro AG
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: de, ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [ANNOUNCE] New netfilter portscan detection module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2001 18:32:54.0839 (UTC) FILETIME=[E5169470:01C08A21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just posted a new portscan detection module to netfilter mailing
list. This module is used inside of linux 2.4 netfilter architecture and
will attempt to detect TCP and UDP port scans and log them to
the syslog.

For download, please see the netfilter mailing list or our product
download site at http://download.astaro.com/patches/

Astaro also started a PSD discussion BB at http://www.astaro.org .
Please visit it, your feedback is welcome :)
--
Dennis Koslowski <dennis.koslowski@astaro.de> | Product Devel.
Astaro AG | http://www.astaro.de  | +49-721-490069-0 | Fax -55
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
