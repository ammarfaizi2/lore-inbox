Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbTDPQqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264521AbTDPQqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:46:51 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:34177 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264528AbTDPQqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:46:43 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304161701.h3GH13Qv001204@81-2-122-30.bradfords.org.uk>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
To: admin@brien.com (Brien)
Date: Wed, 16 Apr 2003 18:01:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003501c30436$b06b8f50$6901a8c0@athialsinp4oc1> from "Brien" at Apr 16, 2003 12:38:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The board supports up to 4 GB total (4 DIMM slots), DDR 400/333/266. I'm
> normally using 2 * 512 MB DDR 400 on Single 128 bit mode. And the board's
> been tested to support up to 4 of the modules that I have (
> KVR400X64C25/512 ) shown at :
> http://www.giga-byte.com/MotherBoard/Support/TechnologyGuide/TechnologyGuide
> _63.htm
> 
> motherboard link:
> http://www.giga-byte.com/MotherBoard/Products/Products_GA-SINXP1394(GA-8SQ80
> 0%20Ultra2).htm
> 
> I tested both modules seperately just minutes ago, AND GET NO ERRORS on
> either one. The errors occur when I have both in.
> 
> I've tried running them different speeds (e.g. 333), and it made no
> difference in what Linux did (black screened after kernel load).

Do you get errors with Memtest86, with both DIMMs installed, and set
to run at 333?

Also, try checking the power supply volatages are within spec.

John.
