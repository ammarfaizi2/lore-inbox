Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290911AbSASEno>; Fri, 18 Jan 2002 23:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290910AbSASEnf>; Fri, 18 Jan 2002 23:43:35 -0500
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:30689 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S290911AbSASEnS>; Fri, 18 Jan 2002 23:43:18 -0500
From: "David Luyer" <david_luyer@pacific.net.au>
To: "'Oliver Xymoron'" <oxymoron@waste.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: vm philosophising
Date: Sat, 19 Jan 2002 15:49:02 +1100
Organization: Pacific Internet (Australia)
Message-ID: <007601c1a0a4$9ddc5d70$46943ecb@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3311
Importance: Normal
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Alan Cox wrote:
> > > There is another VM that has a property that people would like:
> > > deterministically handling memory exhaustion. 
> > > Unfortunately, that VM
> > > probably can't co-exist with over-commit and the 
> > > performance gains that
> > > affords.
> > 
> > It can definitely co-exist. Overcommit control is just a 
> > book keeping
> > exercise on address space commits.

[...]

and the comment I somehow missed putting on the end:

If you want to philosophise about VM strategies, think of
overcommit as "ethernet" and precommit as "token ring".

David.

