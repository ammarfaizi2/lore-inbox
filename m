Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTJTUk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTJTUk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:40:57 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:1479 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262838AbTJTUk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:40:56 -0400
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test8] might sleep
References: <87ekx78z3g.fsf@echidna.jochen.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 20 Oct 2003 13:40:45 -0700
In-Reply-To: <87ekx78z3g.fsf@echidna.jochen.org>
Message-ID: <52ekx7mylu.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Oct 2003 20:40:54.0215 (UTC) FILETIME=[74F5DD70:01C3974A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These might_sleep warnings on boot are fixed in test8-mm1.  They don't
indicate any real problem and you can ignore them for now.

 - Roland


