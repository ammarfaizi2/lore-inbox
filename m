Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTKNNU7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 08:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbTKNNU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 08:20:59 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:20646 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262546AbTKNNU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 08:20:58 -0500
Date: Fri, 14 Nov 2003 14:20:54 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.6] Nonsense-messages from iptables + co.
Message-ID: <20031114132054.GA646@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who the heck added these unhelpful

"ipt_hook: happy cracking."

messages to iptables/mangling/connection tracking code? There are three
instances.

If the kernel has got something to say, it should be clear what the
kernel means, say, maximum <whatever> rate exceeded or something, not
such junk like this.

This is IMHO a MUST-FIX before 2.6.0.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
