Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUA2BT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 20:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUA2BT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 20:19:58 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:18024 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266071AbUA2BT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 20:19:57 -0500
Subject: Re: Re : Alsa create high problems...
From: Eddahbi Karim <installation_fault_association@yahoo.fr>
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <Pine.LNX.4.58.0401230936130.1875@pnote.perex-int.cz>
References: <1074382859.29525.20.camel@gamux>
	 <1074839589.8684.1.camel@gamux>
	 <Pine.LNX.4.58.0401230936130.1875@pnote.perex-int.cz>
Content-Type: text/plain
Organization: Installation Fault
Message-Id: <1075338824.6535.3.camel@gamux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 02:18:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

I've catch the problem !

On my config file, I was using CONFIG_PCI_USE_VECTOR but it seems that I haven't this technology.
This option affects the USB and the sound on my system, so my modem was out and the sound buggy.

Now I removed this option and everything works perfectly.

Thanks to everyone and keep up the good work ;)

Best regards,

-- 
Eddahbi Karim <installation_fault_association@yahoo.fr>
Installation Fault

