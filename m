Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265013AbTFCNpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbTFCNpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:45:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38378
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265013AbTFCNpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:45:09 -0400
Subject: Re: system clock speed too high?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Haumer <andreas@xss.co.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EDC96EA.5020906@xss.co.at>
References: <3EDBA83B.5050406@xss.co.at>
	 <1054582573.7494.51.camel@dhcp22.swansea.linux.org.uk>
	 <3EDC7052.9060109@xss.co.at> <3EDC8DC0.7090009@xss.co.at>
	 <3EDC96EA.5020906@xss.co.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054645247.9359.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 14:00:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB legacy generates SMI events. It could be that something
the BIOS SMI magic is doing is disrupting the system clock
or causing extra interrupts

