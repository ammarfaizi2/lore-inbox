Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162007AbWKVJE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162007AbWKVJE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 04:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162005AbWKVJE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 04:04:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16330 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161995AbWKVJE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 04:04:27 -0500
Subject: Re: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
From: Arjan van de Ven <arjan@infradead.org>
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1164149498.27730.17.camel@localhost.localdomain>
References: <1164149498.27730.17.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 22 Nov 2006 10:04:20 +0100
Message-Id: <1164186260.31358.717.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-21 at 14:51 -0800, Jason Gaston wrote:
> This patch adds the Intel ICH9 AHCI controller DID's for SATA support.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

there was some discussion about a generic class match for ahci...
would these devices be matched by that?


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

