Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVDARl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVDARl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVDARjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:39:37 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:63126 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262824AbVDARim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:38:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SxqshatXkPsUkHizEIS04FVGamG7hzH8EgnlBc79zRyzB1zXJYlr7/BoPU5IqkbcuYR6aV1UGe1ahIjC0stpWsfCvDm7IX3Vj9oVpfcfKmx9E0rjZF40rYCMx4QZ+XTaXPJFsJrwlb7QVJGoqC1E0TIYJp7yx23LhuM8U0D6e+Y=
Message-ID: <e79639220504010938582bade6@mail.gmail.com>
Date: Fri, 1 Apr 2005 19:38:37 +0200
From: Stefan Schweizer <sschweizer@gmail.com>
Reply-To: Stefan Schweizer <sschweizer@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Cc: Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <20050401113335.GA13160@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at>
	 <20050401113335.GA13160@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same issue here.

Suspend-to-ram works perfectly fine with kernel 2.6.12-rc1-mm1, in
mm2,3 and mm4 it is broken.

It suspends properly but does not resume. Just a blackscreen and no
reaction on keypress/usb plug-in/network/power button.

regards,
Stefan
