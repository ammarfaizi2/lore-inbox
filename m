Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132431AbRAHRR6>; Mon, 8 Jan 2001 12:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131941AbRAHRRj>; Mon, 8 Jan 2001 12:17:39 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:43014 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S132431AbRAHRRb>; Mon, 8 Jan 2001 12:17:31 -0500
Date: Mon, 8 Jan 2001 17:15:27 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Paul Powell <moloch16@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'console=' kernel parameter questions
In-Reply-To: <20010108165050.13240.qmail@web119.yahoomail.com>
Message-ID: <Pine.LNX.4.10.10101081714580.26102-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Paul Powell wrote:

> 'console=ttys0','console=cua0','console=ttys0,9600n8', etc....
              ^

console=ttyS0

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
