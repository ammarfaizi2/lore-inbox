Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbTJQK6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTJQK6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:58:16 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:58828 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262804AbTJQK6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:58:15 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Erik Mouw <erik@harddisk-recovery.com>, Josh Litherland <josh@temp123.org>
Subject: Re: Transparent compression in the FS
Date: Fri, 17 Oct 2003 12:55:46 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
In-Reply-To: <20031015133305.GF24799@bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171255.46402.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 October 2003 15:33, Erik Mouw wrote:
> On Tue, Oct 14, 2003 at 04:30:50PM -0400, Josh Litherland wrote:
> > Are there any filesystems which implement the transparent compression
> > attribute ?  (chattr +c)
>
> Nowadays disks are so incredibly cheap, that transparent compression
> support is not realy worth it anymore (IMHO).

But disk bandwidth is still a problem and compression helps out here.


