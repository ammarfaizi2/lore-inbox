Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754256AbWKMIAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbWKMIAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754265AbWKMIAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:00:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12715 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754256AbWKMIAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:00:05 -0500
Subject: Re: [PATCH] Bring ext2 reservations code in line with latest ext3
From: Arjan van de Ven <arjan@infradead.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cmm@us.ibm.com, val_henson@linux.intel.com
In-Reply-To: <4557BFD7.5010405@mbligh.org>
References: <200611090841.kA98feVx010502@shell0.pdx.osdl.net>
	 <4557BFD7.5010405@mbligh.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 08:59:55 +0100
Message-Id: <1163404795.15249.101.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 16:44 -0800, Martin J. Bligh wrote:
> Did a pass through comparing the functions changed by the ext2
> reservations patch to current ext3 code. Fixed up comments and
> typedefs to match latest ext3 code.


time for a libreservation so that it can be shared between the two ?

