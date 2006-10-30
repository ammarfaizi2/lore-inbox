Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWJ3MId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWJ3MId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWJ3MId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:08:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54913 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751249AbWJ3MIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:08:32 -0500
Subject: Re: [RFC 0/7][PATCH] AMBA DMA: Request for comments.
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Pearse <peter.pearse@arm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <CAM-OWA113ITAU0koed00000001@cam-owa1.Emea.Arm.com>
References: <CAM-OWA113ITAU0koed00000001@cam-owa1.Emea.Arm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 30 Oct 2006 13:08:29 +0100
Message-Id: <1162210109.2948.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 11:57 +0000, Peter Pearse wrote:
> The following seven patches against the kernel tag v2.6.19-rc3, are intended
> as a basis for discussion of a possible ARM AMBA bus based DMA architecture.
> An example implementation for audio playback is given.


Hi,

a quick question; is this using the generic dma stuff that was added as
part of the ioat patches? If not, why not? What is missing in the
generic stuff etc etc...

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

