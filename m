Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269798AbUJGL7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269798AbUJGL7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269800AbUJGL7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:59:47 -0400
Received: from smtp07.web.de ([217.72.192.225]:9899 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S269798AbUJGL7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:59:46 -0400
Date: Thu, 7 Oct 2004 14:08:54 +0200
From: Hanno Meyer-Thurow <h.mth@web.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-Id: <20041007140854.06afee88.h.mth@web.de>
In-Reply-To: <20041007114434.GA21937@elte.hu>
References: <20040922103340.GA9683@elte.hu>
	<20040923122838.GA9252@elte.hu>
	<20040923211206.GA2366@elte.hu>
	<20040924074416.GA17924@elte.hu>
	<20040928000516.GA3096@elte.hu>
	<20041003210926.GA1267@elte.hu>
	<20041004215315.GA17707@elte.hu>
	<20041005134707.GA32033@elte.hu>
	<20041007105230.GA17411@elte.hu>
	<20041007134116.3e53b239.h.mth@web.de>
	<20041007114434.GA21937@elte.hu>
X-Mailer: Sylpheed version 0.9.12-gtk2-20040918 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 13:44:34 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> ok, this happens if PREEMPT_TIMING is not enabled. I've re-uploaded the
> new -T3 patch, please re-download it.
> 
> 	Ingo

great! it works, thanks :)
