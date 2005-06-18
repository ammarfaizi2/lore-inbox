Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVFRWQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVFRWQE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVFRWQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:16:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45970 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262184AbVFRWPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:15:51 -0400
Subject: Re: bad: scheduling while atomic!: how bad?
From: Lee Revell <rlrevell@joe-job.com>
To: David L <idht4n@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY104-F697F218C7E4E45B78BCDA84F70@phx.gbl>
References: <BAY104-F697F218C7E4E45B78BCDA84F70@phx.gbl>
Content-Type: text/plain
Date: Sat, 18 Jun 2005 18:18:44 -0400
Message-Id: <1119133125.4560.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-18 at 14:59 -0700, David L wrote:
> I'm seeing the message:
> 
> bad: scheduling while atomic!

It indicates a kernel bug, which could range from harmless to very bad.

Usually that message is accompanied by a stack trace, can you provide a
real log excerpt?

Lee

