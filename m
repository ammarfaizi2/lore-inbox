Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUHXRmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUHXRmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUHXRmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:42:02 -0400
Received: from fmr05.intel.com ([134.134.136.6]:58538 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266825AbUHXRlS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:41:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [broken?] Add MSI support to e1000
Date: Tue, 24 Aug 2004 10:40:43 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024061F9C76@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [broken?] Add MSI support to e1000
Thread-Index: AcSJmei8aTMh6M0tTHWipRsxPgc0PwAZzf8w
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andi Kleen" <ak@muc.de>
Cc: "Roland Dreier" <roland@topspin.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Aug 2004 17:40:44.0444 (UTC) FILETIME=[7B7A75C0:01C48A01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2004  Andi Kleen wrote:
>I guess it's an x86-64 specific issue? Did you test that recently?

I just tested an x86-64 MSI support in 2.6.8.1 kernel. It works fine.

Thanks,
Long
