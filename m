Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265495AbUEZLhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbUEZLhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbUEZLhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:37:53 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12714 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265496AbUEZLgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:36:06 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'John Bradford'" <john@grabjohn.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>, <orders@nodivisions.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 04:39:50 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDA6vUYzu3ANKsSMCwDndRH8i3LQAEnhNQ
Message-Id: <S265496AbUEZLgG/20040526113746Z+1680@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exactly ...

-----Original Message-----
From: John Bradford [mailto:john@grabjohn.com] 
Sent: Wednesday, May 26, 2004 2:35 AM
To: Nick Piggin; Buddy Lumpkin
Cc: 'William Lee Irwin III'; orders@nodivisions.com;
linux-kernel@vger.kernel.org
Subject: Re: why swap at all?

Quote from Nick Piggin <nickpiggin@yahoo.com.au>:
> Even for systems that don't *need* the extra memory space, swap can
> actually provide performance improvements by allowing unused memory
> to be replaced with often-used memory.

That's true, but it's not a magical property of swap space - extra physical
RAM would do more or less the same thing.

John.

