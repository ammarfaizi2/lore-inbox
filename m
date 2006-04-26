Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWDZOPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWDZOPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWDZOPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:15:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:50875 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932450AbWDZOPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:15:02 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] i386/x86-64: simplify ioapic_register_intr()
Date: Wed, 26 Apr 2006 16:14:59 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <444F9B65.76E4.0078.0@novell.com>
In-Reply-To: <444F9B65.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261614.59768.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 16:10, Jan Beulich wrote:
> Simplify (remove duplication of) code in ioapic_register_intr().

Applied thanks.
-Andi
