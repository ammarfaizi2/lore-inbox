Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVATCPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVATCPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVATCPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:15:04 -0500
Received: from mail.inter-page.com ([207.42.84.180]:62225 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261841AbVATCO0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:14:26 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Robert White'" <rwhite@casabyte.com>, <linux@horizon.com>,
       <linux-kernel@vger.kernel.org>
Cc: <lm@bitmover.com>, <torvalds@osdl.org>
Subject: RE: Make pipe data structure be a circular list of pages, rather than
Date: Wed, 19 Jan 2005 18:14:12 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAcWYJmMV4PU+XcGbFG9FTdAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



P.S.  Not to reply to myself... 8-)  I took some liberties with that description.
STREAMS doesn't, to the best of my knowledge, have the cleanup hook stuff.  That was
me folding your issues (direct PCI device buffers etc) from this thread on top of the
basic skeleton of STREAMS to broaden the "impedance matching" possibilities.

(No really, back to lurking... 8-)

Rob White,
Casabyte, Inc.

