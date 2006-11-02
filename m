Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752451AbWKBKv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbWKBKv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbWKBKv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:51:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61341 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752451AbWKBKv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:51:26 -0500
Subject: RE: Can Linux live without DMA zone?
From: Arjan van de Ven <arjan@infradead.org>
To: Conke Hu <conke.hu@amd.com>
Cc: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F358602F2D5DF@shacnexch2.atitech.com>
References: <FFECF24D2A7F6D418B9511AF6F358602F2D5DF@shacnexch2.atitech.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 02 Nov 2006 11:51:22 +0100
Message-Id: <1162464682.14530.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 18:33 +0800, Conke Hu wrote:
> Most PCs do not have ISA or floppy, so maybe we could add an option to enable DMA zone or not.
> 

please don't top-post. 


also floppy is still there a lot unfortunately ... as are some of the
more crappy soundcards. ZONE_DMA is a 32 bit linux thing; most modern
systems are 64 bit capable now....

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

