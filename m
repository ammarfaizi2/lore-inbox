Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030709AbWKOUTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030709AbWKOUTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030875AbWKOUTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:19:36 -0500
Received: from hera.kernel.org ([140.211.167.34]:44451 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030709AbWKOUTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:19:35 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] ACPI: use MSI_NOT_SUPPORTED bit
Date: Wed, 15 Nov 2006 15:19:40 -0500
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       jeff@garzik.org, linux-kernel@vger.kernel.org, tiwai@suse.de
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <p73ejs5co0q.fsf@bingen.suse.de> <20061115103525.19e9d3eb.randy.dunlap@oracle.com>
In-Reply-To: <20061115103525.19e9d3eb.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151519.40809.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anybody found a system with the MSI_NOT_SUPPORTED
reported by ACPI?

Here is how to check:
http://marc.theaimsgroup.com/?l=linux-acpi&m=115941857423136&w=2

thanks,
-Len
