Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758514AbWLDV03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758514AbWLDV03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759702AbWLDV02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:26:28 -0500
Received: from cs9347-45.austin.rr.com ([24.93.47.45]:63922 "EHLO
	ms-smtp-06.texas.rr.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1758514AbWLDV01 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:26:27 -0500
Message-Id: <200612042125.kB4LPmld014172@ms-smtp-06.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Jeffrey Hundstad'" <jeffrey.hundstad@mnsu.edu>
Cc: "'Christoph Lameter'" <clameter@sgi.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Horst H. von Brand'" <vonbrand@inf.utfsm.cl>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <dcn@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Mon, 4 Dec 2006 15:25:47 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <45746B1B.5060809@mnsu.edu>
Thread-Index: AccX03tyxQw+CMOJQBKEPiy+lUgI6wAEayEQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeffrey Hundstad [mailto:jeffrey.hundstad@mnsu.edu]
> POSIX_FADV_NOREUSE flags.  It seems these would cause the tar and patch

WI may be naïve as well, but that sounds interesting. Unless someone knows
of an obvious reason this won't work we can make a one-off tar command and
give it a whirl.


