Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbUAJLHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 06:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUAJLHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 06:07:15 -0500
Received: from levante.wiggy.net ([195.85.225.139]:226 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S265078AbUAJLHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 06:07:13 -0500
Date: Sat, 10 Jan 2004 12:07:11 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Peng Yong <ppyy@bentium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system resource limit in kernel 2.6
Message-ID: <20040110110711.GB29693@wiggy.net>
Mail-Followup-To: Peng Yong <ppyy@bentium.com>,
	linux-kernel@vger.kernel.org
References: <20040110095333.0765.PPYY@bentium.com> <20040109182450.462bc537.akpm@osdl.org> <20040110104249.076E.PPYY@bentium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110104249.076E.PPYY@bentium.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Peng Yong wrote:
> httpd.conf:

Apache does not commonly run a process as the nobody user (uid 65534) so
it is most likely another process on your server.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

