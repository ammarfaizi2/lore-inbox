Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWAUQps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWAUQps (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 11:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWAUQpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 11:45:47 -0500
Received: from fmr13.intel.com ([192.55.52.67]:22986 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932160AbWAUQpr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 11:45:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: __cpuinit functions wrongly marked __meminit
Date: Sat, 21 Jan 2006 08:45:06 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C29FF8B@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: __cpuinit functions wrongly marked __meminit
Thread-Index: AcYeKzsp/i6L3kbxQO+a5E9HSxoHeAAdWDPg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Raj, Ashok" <ashok.raj@intel.com>, <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>, <ak@muc.de>
X-OriginalArrivalTime: 21 Jan 2006 16:45:07.0521 (UTC) FILETIME=[0941AB10:01C61EAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <mailto:ashok.raj@intel.com> wrote:
> Hi Andrew
> 
> This is required, __meminit has overzelously been modified and crept
> its way into marking cpuup callbacks as __meminit.

Indeed, thanks Ashok.

matt
