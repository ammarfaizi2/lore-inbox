Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270931AbTGVVqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270948AbTGVVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:46:07 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:40943 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270931AbTGVVqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:46:05 -0400
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
Cc: Jason Baron <jbaron@redhat.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1DA09F.4020503@gibraltar.at>
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>
	 <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>
	 <3F1D7C80.6020605@gibraltar.at>
	 <1058904025.4160.30.camel@dhcp22.swansea.linux.org.uk>
	 <3F1DA09F.4020503@gibraltar.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058910871.4674.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jul 2003 22:54:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give vanilla 2.4.22-pre7 a go. I suspect it'll break the same if its the unshare stuff

