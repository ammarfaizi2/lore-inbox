Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267909AbUHKDSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267909AbUHKDSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267910AbUHKDSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:18:36 -0400
Received: from Jupiter.Toms.NET ([64.32.223.162]:57286 "EHLO jupiter.toms.net")
	by vger.kernel.org with ESMTP id S267909AbUHKDSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:18:33 -0400
Date: Tue, 10 Aug 2004 23:18:29 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: linux-kernel@vger.kernel.org
Subject: du + minix = problem on 2.6
In-Reply-To: <Pine.LNX.4.58.0408102258590.502@jupiter.toms.net>
Message-ID: <Pine.LNX.4.58.0408102316060.502@jupiter.toms.net>
References: <Pine.LNX.4.58.0408102250220.502@jupiter.toms.net>
 <Pine.LNX.4.58.0408102258590.502@jupiter.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


P.S., I discovered that this minix/du/2.6 bug was reported in February,

Essentially, it seems all minix "du" counts are way way wrong,

Actually, I think all files report 1 block usage on minix now...

-Tom

