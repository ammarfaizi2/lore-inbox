Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290731AbSBFScn>; Wed, 6 Feb 2002 13:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290733AbSBFScX>; Wed, 6 Feb 2002 13:32:23 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:58127 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S290731AbSBFScN>; Wed, 6 Feb 2002 13:32:13 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A768A@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Russell King'" <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: what serial driver restructure is planned?
Date: Wed, 6 Feb 2002 10:32:11 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> o Beta       Serial driver restructure              (Russell King)

Regarding the above line from the 2.5 STATUS report, what is the nature of
the planned restructuring?  I have a CompactPCI hot swap serial mux card
that I need to support with hot swap functionality on Linux.  Has anybody
already worked on issues like locking port names to physical slots, etc.?
Any basic advice?

Thanks in
Ed Vance
 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
