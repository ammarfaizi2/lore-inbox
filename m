Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTDPTOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbTDPTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:14:33 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:38017 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264545AbTDPTOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:14:32 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304161928.h3GJSopS001481@81-2-122-30.bradfords.org.uk>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
To: admin@brien.com (Brien)
Date: Wed, 16 Apr 2003 20:28:50 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), linux-kernel@vger.kernel.org
In-Reply-To: <001d01c30444$2fbd05b0$6901a8c0@athialsinp4oc1> from "Brien" at Apr 16, 2003 02:15:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've now tried running the following configurations

[snip]

> and all of them have the same problem: black screen after kernel loads
> they all do seem to test with errors when ran with another module, but they
> also DO NOT test as errors when they're alone

OK...  Do you get the same locations failing with one pair of DIMMs as
with another identical pair of DIMMs, or is it just randomly flakey?

> I'm starting to think it's a problem with my motherboard rather than with
> the RAM, because I've tried so many different ways and with different RAM
> modules.. but I don't know for sure..

Are you sure it's not the power supply?  If the voltages are only just
within spec, you could concievably get the behavior you describe.

> basically every time I try to run any linux distribution, even if I
> type (mem=XXXM), it just doesn't work...

I wouldn't even bothing trying to run anything on a machine until it
runs Memtest86 for a couple of hours successfully.

John.
