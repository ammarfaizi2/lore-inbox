Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTLPOCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 09:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLPOCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 09:02:55 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:17792 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261735AbTLPOCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 09:02:54 -0500
Date: Tue, 16 Dec 2003 15:02:52 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 make menuconfig bugreport
Message-ID: <20031216150252.A722@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Device Drivers ->
Input device support ->
--- Mouse interface <Help>
"Say Y here if you want [...] If unsure, say Y."
There is no way how to say anything here. It's a fixed
entry beginning with "---"

Cl<
