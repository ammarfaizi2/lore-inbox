Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbUKQTgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUKQTgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbUKQTeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:34:03 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:26520 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262429AbUKQTc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:32:56 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 start_udev very slow
Date: Wed, 17 Nov 2004 19:32:47 +0000
User-Agent: KMail/1.7
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411171932.47163.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that when upgrading from 2.6.8.1 to rc2, start_udev now takes 10-15s 
after printing

"Creating initial udev device nodes:"

Any known reason? should I upgrade udev? (030 installed)

Andrew Walrond
