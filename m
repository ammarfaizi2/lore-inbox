Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVASUCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVASUCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVASUCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:02:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:54215 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261761AbVASUB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:01:58 -0500
X-Authenticated: #206784
From: Dominique Simon <d.simon@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix verify_command to allow burning more than 1 DVD
Date: Wed, 19 Jan 2005 21:01:45 +0100
User-Agent: KMail/1.7.1
References: <41EC214D.6060607@stud.feec.vutbr.cz>
In-Reply-To: <41EC214D.6060607@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501192101.46634.d.simon@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 17. Januar 2005 21:34 schrieb Michal Schmidt:
> The bug is in the kernel in the function verify_command.

Your patch works fine. Nasty bug that was...

Ciao
