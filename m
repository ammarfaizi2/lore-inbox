Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUAMU7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265647AbUAMU7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:59:37 -0500
Received: from ihemail2.lucent.com ([192.11.222.163]:32222 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265644AbUAMU7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:59:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16388.16059.583605.176947@gargle.gargle.HOWL>
Date: Tue, 13 Jan 2004 13:53:47 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Henrique Oliveira <henrique.oliveira@cyclades.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Daniela Squassoni <daniela@cyclades.com>
Subject: Re: [2/3]
In-Reply-To: <4004310B.4090802@cyclades.com>
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>
	<20040113113650.A2975@flint.arm.linux.org.uk>
	<20040113114948.B2975@flint.arm.linux.org.uk>
	<20040113171544.B7256@flint.arm.linux.org.uk>
	<20040113173352.D7256@flint.arm.linux.org.uk>
	<4004310B.4090802@cyclades.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Henrique> I am no longer the maintainer of the Cyclades driver
Henrique> (char/cyclades.c).  Could you please remove my name from
Henrique> that driver and include Daniela as the official maintainer
Henrique> <daniela@cyclades.com> ?

Wouldn't it make more sense for you people at Cyclades to setup an
email alias like 'linux-driver@cyclades.com' so we can update the
kernel sources once, and then you can update your internal email alias
as things change?  

Seems like the better way to go...

John
