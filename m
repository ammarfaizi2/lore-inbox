Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTD3Eni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 00:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbTD3Enh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 00:43:37 -0400
Received: from gw.enyo.de ([212.9.189.178]:17416 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262095AbTD3Enh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 00:43:37 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
References: <20030429231009$1e6b@gated-at.bofh.it>
In-Reply-To: <20030429231009$1e6b@gated-at.bofh.it> (Andrew Morton's message
 of "Wed, 30 Apr 2003 01:10:09 +0200")
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Wed, 30 Apr 2003 06:55:55 +0200
Message-ID: <87k7dcinxg.fsf@deneb.enyo.de>
User-Agent: Gnus/5.09002 (Oort Gnus v0.20) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> net/
> ----

What about the dst cache DoS attack?
