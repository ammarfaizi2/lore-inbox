Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937541AbWLEN1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937541AbWLEN1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 08:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937549AbWLEN1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 08:27:34 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:49545 "EHLO
	ms-smtp-01.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937541AbWLEN1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 08:27:33 -0500
Message-Id: <200612051327.kB5DRDwr011027@ms-smtp-01.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Rene Herman'" <rene.herman@gmail.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Tue, 5 Dec 2006 07:27:13 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <45751F19.9010208@gmail.com>
Thread-Index: AccYPsg/Q6RtM1WfSeaWedDhTfyy5QAMhKBA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rene Herman [mailto:rene.herman@gmail.com]
> ftruncate there and some similarity to a problem I once experienced

I can't honestly say I completely grasp the fundamentals of the issue you
experienced but we are using ext3 with data=journal


