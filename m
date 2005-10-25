Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVJYVNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVJYVNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVJYVNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:13:54 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58259 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932383AbVJYVNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:13:53 -0400
Subject: Re: PROBLEM: Bad page state
From: Lee Revell <rlrevell@joe-job.com>
To: Tomasz Karwot <adminek@wb.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <435E9478.1060104@wb.pl>
References: <435E9478.1060104@wb.pl>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 17:11:16 -0400
Message-Id: <1130274676.4483.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 22:24 +0200, Tomasz Karwot wrote:
> Oct 24 08:26:01 skretka kernel: Bad page state at free_hot_cold_page (in 
> process 'java', page c101b7e0) - (Not only this process, other too 
> (firefox etc...))

Tainted kernel.  This report is useless.

Please reproduce with no proprietary drivers loaded.  And you only need
to provide the first instance, not the complete log.

Lee

