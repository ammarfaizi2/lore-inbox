Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUBOPGS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUBOPGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:06:18 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:42925 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264942AbUBOPGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:06:13 -0500
Date: Sun, 15 Feb 2004 09:06:11 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: Speaker static, vanishes with APIC
Message-ID: <Pine.LNX.4.58.0402150903010.1774@ryanr.aptchi.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is really trivial and I solved it anyway, but in all incarnations of 2.6 I
have had static coming from my speakers shortly after boot.  It only lasts a few
seconds and sounds as though someone were jiggling the plug in the sound card's
socket.  It only happens right after boot.  Since I enabled Local APIC and
IO-APIC it hasn't happened.

Sound card module is snd-intel8x0, and my card is built into my Shuttle AN35N
motherboard.

-- 
Ryan Reich
ryanr@uchicago.edu
