Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTJNQca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 12:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTJNQca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 12:32:30 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:128 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262589AbTJNQc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 12:32:29 -0400
Date: Tue, 14 Oct 2003 18:32:26 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Vortex 3c900 passing driver parameters
Message-ID: <20031014183226.A188@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

How do I do a ether=... (kernel boot-time) equivalent of
insmod 3c59x.o options=0x201 full_duplex=1 ?

I have been looking in Documentation/networking/vortex.txt
and make htmldocs, also on the driver homepage at Scyld and found
it on none of these places.

Cl<
