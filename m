Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTICCZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 22:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTICCZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 22:25:20 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:10372 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264027AbTICCZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 22:25:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16213.20743.792304.759727@gargle.gargle.HOWL>
Date: Tue, 2 Sep 2003 22:25:11 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, stoffel@lucent.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test4-mm4 - USD disconnect oops
In-Reply-To: <20030902181336.5dfe624f.akpm@osdl.org>
References: <16210.44543.579049.520185@gargle.gargle.HOWL>
	<20030901065928.GB22647@kroah.com>
	<16213.12008.527588.874265@gargle.gargle.HOWL>
	<20030903000448.GA21173@kroah.com>
	<20030902181336.5dfe624f.akpm@osdl.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew & Greg,

Yup, that patch fixed the USB issues I had.  And since I've upgraded
the lspci tools, I can even see what drivers to use for each port, so
I've gone back to the stock usb.rc script.

Thanks to both of you!  

John
