Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUKUXLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUKUXLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbUKUXLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:11:12 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:17797 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261830AbUKUXLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:11:10 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [BUG][2.6.10-rc2-mm2] ACPI S3 suspend to RAM broken (may be USB unable to resume)
Date: Sun, 21 Nov 2004 18:11:07 -0500
User-Agent: KMail/1.7
Cc: acpi-devel@lists.sourceforge.net
References: <200411161838.28344.shawn.starr@rogers.com>
In-Reply-To: <200411161838.28344.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411211811.07785.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-mm2 suffers this problem as well. I still am looking at what is causing it.

On November 16, 2004 18:38, Shawn Starr wrote:
> As of 2.6.10-rc1 + I can no longer resume from S3 (suspend-to-RAM),  When
> it begins to resume, it seems to get stuck with USB (going to confirm)..
> The laptop stays in a stuck state (cresent-moon remains lit).
>
> I have IBM-ACPI extras turned on (compiled in).
>
> Anyone else report this?
>
> Shawn.
