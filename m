Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbTL3E2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTL3E2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:28:36 -0500
Received: from pool-64-223-239-211.port.east.verizon.net ([64.223.239.211]:40189
	"EHLO evilbint.mylan") by vger.kernel.org with ESMTP
	id S264384AbTL3E2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:28:35 -0500
Date: Mon, 29 Dec 2003 23:28:34 -0500
From: Greg Fitzgerald <gregf@bigtimegeeks.com>
To: linux-kernel@vger.kernel.org
Subject: psmouse_proto=exps
Message-ID: <20031230042834.GA32087@evilbint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I am using a Raritan Switchman kvm switch, with a Logitech MX 500 optical mouse. I have tried using 2.6.0, 2.6.0-mm1, 2.6.0-mm2, and 2.6.0-bk1. I can move the mouse around with no problems but when i try to use my scrollwheel instead of scrolling up and down my mouse cursor just moves across the screen. It works perfect in 2.4.23. I been reading the lists and i have tried using psmouse_proto=exps but have had the same results, i even tried the other drivers just to see if that would fix it but i keep coming up with the same results. Anyone have some ideas? Thanks in adavance.

	--Greg
