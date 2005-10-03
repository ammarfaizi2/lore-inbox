Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVJCR0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVJCR0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVJCR0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:26:44 -0400
Received: from amdext4.amd.com ([163.181.251.6]:5302 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932430AbVJCR0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:26:43 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Mon, 3 Oct 2005 11:43:36 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: [PATCH 0/7] AMD Geode GX/LX support
Message-ID: <20051003174336.GB29264@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5FB64D2RW1373134-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following seven patches add support for the AMD Geode GX and LX
processors, as well as some drivers and fixes for various components within
the processors or the CS5535/CS5536 companion chips.

Two of the patches are IDE related, so I'll only CC the linux-ide list for
those to keep traffic down (please don't be confused by the numbering).

Please CC back to the info-linux@ldcmail.amd.com mailing list so all of
our developers can participate in the discussion.

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

