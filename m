Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVC2OrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVC2OrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 09:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVC2OrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 09:47:16 -0500
Received: from graphe.net ([209.204.138.32]:56078 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262301AbVC2OrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 09:47:14 -0500
Date: Tue, 29 Mar 2005 06:47:10 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] timers: description
In-Reply-To: <42493B88.A481AB1F@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0503290646380.14531@server.graphe.net>
References: <200503261952.j2QJq1g27569@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0503281111220.26639@server.graphe.net> <42493B88.A481AB1F@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005, Oleg Nesterov wrote:

> > Same problems here with occasional hangs w/o changes to schedule_timeout.
>
> Bad. You are runnning 2.6.12-rc1-mm1 ?

Not sure if this is really related to your patches. Its 2.6.11 with your
patches extracted from mm.

