Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbTIVMiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTIVMiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:38:15 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:11136 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263134AbTIVMiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:38:12 -0400
Date: Mon, 22 Sep 2003 13:42:55 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309221242.h8MCgtMf000302@81-2-122-30.bradfords.org.uk>
To: aebr@win.tue.nl, ndiamond@wta.att.ne.jp, vojtech@suse.cz
Subject: Translated set 3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if there is an obvious answer to this question that I'm missing,
but what is the advantage of using translation in set 3?

I totally agree that translated set 2 is the way to get 99% of
keyboards working perfectly, and that the reason we use translation
here, is because although untranslated set 2 is simpler, some laptops
don't support this properly, and some that do have problems with BIOS
interpretation of the codes, etc.

However, surely setups that support set 3, will support it equally
well with and without translation?  Here, I don't see the advantage of
enabling translation.

Why not simplify the whole problem, and either have:

* translated set 2 with workarounds for all known strange keyboards
* untranslated set 3

John.
