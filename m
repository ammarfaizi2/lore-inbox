Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273049AbTHKSPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273030AbTHKSOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:14:33 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:58373 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S272997AbTHKSMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:12:50 -0400
To: Hugh Dickins <hugh@veritas.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test3] Hyperthreading gone
References: <Pine.LNX.4.44.0308111734490.1365-100000@localhost.localdomain>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Mon, 11 Aug 2003 20:12:46 +0200
In-Reply-To: <Pine.LNX.4.44.0308111734490.1365-100000@localhost.localdomain> (Hugh
 Dickins's message of "Mon, 11 Aug 2003 17:52:44 +0100 (BST)")
Message-ID: <87smo8xdup.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

> Florian, at the moment, in 2.4 and in 2.6, you do have to specify the
> "acpismp=force" boot parameter to get HT to work with CPU Enumeration
> Only:

With 2.4, I get hyperthreading without any ACPI configuration option.
