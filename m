Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUJDWOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUJDWOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUJDWNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:13:45 -0400
Received: from host217-42-111-215.range217-42.btcentralplus.com ([217.42.111.215]:13775
	"EHLO worthy.swandive.local") by vger.kernel.org with ESMTP
	id S268683AbUJDWLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:11:31 -0400
Message-ID: <4161CA7E.6090601@btinternet.com>
Date: Mon, 04 Oct 2004 23:11:10 +0100
From: Grant Wilson <gww@btinternet.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040927)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: s.rivoir@gts.it, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
References: <20041004020207.4f168876.akpm@osdl.org>	<4161462A.5040806@gts.it>	<20041004121805.2bffcd99.akpm@osdl.org>	<4161BCCB.4080302@btinternet.com>	<20041004143253.50a82050.akpm@osdl.org> <20041004143953.10e6d764.akpm@osdl.org>
In-Reply-To: <20041004143953.10e6d764.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> You could try these instead:

With the second preempt_disable() in the first part of the patch
changed to a preempt_enable() my box now boots.

Thanks,
Grant
