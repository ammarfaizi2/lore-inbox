Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUCILLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUCILLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:11:31 -0500
Received: from smtp05.web.de ([217.72.192.209]:1803 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261875AbUCILKD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:10:03 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Date: Tue, 9 Mar 2004 12:09:50 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200403090014.03282.thomas.schlichter@web.de> <20040308163316.47b8172b.akpm@osdl.org>
In-Reply-To: <20040308163316.47b8172b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403091209.52324.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. März 2004 01:33 schrieb Andrew Morton:
> Thomas Schlichter <thomas.schlichter@web.de> wrote:
> > P.S.: Wouldn't it be nice if gcc complained about these mistakes?
>
> It does, with -W.  But -W creates vast amounts of less useful warnings.

Ah, OK... Thanks!

