Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTAaP2N>; Fri, 31 Jan 2003 10:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTAaP2N>; Fri, 31 Jan 2003 10:28:13 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:27084 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261486AbTAaP2M> convert rfc822-to-8bit; Fri, 31 Jan 2003 10:28:12 -0500
Content-Type: text/plain;
  charset="iso-8859-2"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Krzysztof =?iso-8859-2?q?Ol=EAdzki?= <ole@ans.pl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Default mount options ignored on ext3
Date: Fri, 31 Jan 2003 16:37:23 +0100
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.33.0301311510460.22604-100000@dark.pcgames.pl>
In-Reply-To: <Pine.LNX.4.33.0301311510460.22604-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301311637.23190.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 January 2003 15:18, Krzysztof Olêdzki wrote:

Hi Krzysztof,

> It seems that "Default mount options" from ext3 fs is ignored by
> the linux kernel. I have just set "Default mount options" to
> "journal_data" on my root fs but kernel still mounts it with
> journal_data_ordered:
I am pretty sure you didn't try "append=rootflags=data=journal" did you? :)

ciao, Marc
