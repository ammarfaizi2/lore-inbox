Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965692AbWKHMzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965692AbWKHMzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965694AbWKHMzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:55:19 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:45586 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965692AbWKHMzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:55:18 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: 2.6.19-rc5-mm1
Date: Wed, 8 Nov 2006 13:54:23 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611081307.27365.m.kozlowski@tuxland.pl> <200611081332.36644.mail@earthworm.de>
In-Reply-To: <200611081332.36644.mail@earthworm.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611081354.23671.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witam, 

> On Wednesday 08 November 2006 13:07, Mariusz Kozlowski wrote:
> > Hello,
> >
> > 	This was seen on athlon machine with 'make allmodconfig'.
> 
> You need binutils >= 2.16.91.0.2 if CONFIG_KVM is enabled. See "[PATCH 0/14] 
> KVM: Kernel-based Virtual Machine (v4)" for details and discussion.

True. Thanks.

-- 
Regards,

	Mariusz Kozlowski
