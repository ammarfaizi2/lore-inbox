Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVAKP3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVAKP3h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVAKP3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:29:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:24859 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262797AbVAKP30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:29:26 -0500
Date: Tue, 11 Jan 2005 15:29:00 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Daniel Fenert <daniel@fenert.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: "kernel BUG at mm/rmap.c:474!" error on 2.6.9
In-Reply-To: <20050111152338.GB31934@fenert.net>
Message-ID: <Pine.LNX.4.44.0501111525330.2873-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Daniel Fenert wrote:
> 
> I hardly can touch this machine,

Understood: thanks for trying.

> but I'll try tomorrow morning run memtest86 for some 20 minutes.

If it reports an error, that will be significant.  But if it does
not, I don't think we can conclude anything from such a short run.
Anyway, better than nothing.

> I'll try the patch.

Much appreciated.

Hugh

