Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVINAUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVINAUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 20:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVINAUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 20:20:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:25542 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964917AbVINAUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 20:20:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43276CC3.20105@s5r6.in-berlin.de>
Date: Wed, 14 Sep 2005 02:20:19 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
CC: Pavel Machek <pavel@ucw.cz>, Jan De Luyck <lkml@kcore.org>
Subject: Re: ACPI S3 and ieee1394 don't get along
References: <200509131156.31914.lkml@kcore.org> <20050913102049.GA1876@elf.ucw.cz>
In-Reply-To: <20050913102049.GA1876@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.534) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Last time I checked, you could still break ohci1394 be repeatedly
> loading it and unloading it.

Do you have details available on that?

I never saw such a bug with the two PCI OHCI controllers I can currently 
test. I'm not running any isochronous applications though.
-- 
Stefan Richter
-=====-=-=-= =--= -===-
http://arcgraph.de/sr/
