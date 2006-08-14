Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752036AbWHNSPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbWHNSPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWHNSPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:15:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33713 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752036AbWHNSPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:15:36 -0400
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/2] x86_64: Detect clock skew during suspend
Date: Mon, 14 Aug 2006 20:15:30 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200608132303.00012.rjw@sisk.pl> <200608132307.40741.rjw@sisk.pl>
In-Reply-To: <200608132307.40741.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608142015.30745.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 23:07, Rafael J. Wysocki wrote:
> Detect the situations in which the time after a resume from disk would
> be earlier than the time before the suspend and prevent them from
> happening on x86_64.

Merged thanks

-Andi
