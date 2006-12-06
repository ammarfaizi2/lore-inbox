Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937667AbWLFVZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937667AbWLFVZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937666AbWLFVZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:25:24 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:22469 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937667AbWLFVZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:25:22 -0500
X-YMail-OSG: LlkaOuIVM1mtpcy0oPb1dUz1tVFDdYR42bmWz9vBt.5PfHZxmDLkQe4zh87FDrA_Fr8xtK8_TnECbLcRyHGhyWt_.xrL.10J4X9OUFnsD2.8isHajUhbuo4V4LeuHKgI_i7xM2zl11Fx.w--
Date: Wed, 6 Dec 2006 13:25:17 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christian <christiand59@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives
Message-ID: <20061206212517.GA18803@tuatara.stupidest.org>
References: <4570CF26.8070800@scientia.net> <20061203011737.GA2729@us.ibm.com> <200612061211.38892.christiand59@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612061211.38892.christiand59@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 12:11:38PM +0100, Christian wrote:

> I copied a massive amount of data (more than 500GB) several times
> between the HDDs and ran md5sum each time, but it found no errors.

It might be a known problem that your BIOS addresses already, or maybe
it's restricted to some revisions of the chip(s)?

