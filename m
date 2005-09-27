Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVI0IFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVI0IFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVI0IFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:05:13 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:23788 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964853AbVI0IFL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:05:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GRCPQMuT8DRDXiFhoNqGYJeDwQ0zA38TxHWPpFGLztLmvnUN/xEgpQwa+zlz1qMu6iL29h232tx/vmKhQMsd0Xuf64i6MlkLG+cnzdBU/OuCm9X1ieu+UWvzlMH2TKQBahzxEThh1Hl3LYICZG3r7xQ4GiD2f/7X5mnleonwnfg=
Message-ID: <2cd57c9005092701055f96e629@mail.gmail.com>
Date: Tue, 27 Sep 2005 16:05:09 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050926120850.30349.qmail@web51012.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050926120850.30349.qmail@web51012.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
> Hi folks,
>
> For my EndThesis, in the Niederrhein University of
> Applied Sciences, I've almost finished a framework
> that generates a .config file based on the target
> system.This program should help people to generate a
> linux kernel Config without spending a lot of time at
> the configuration.
>
> The basic idea of the framework is, that you can
> specify in the Kconfig files a script which
> auto-detect if the hardware involved in this option is
> present or not (the script reply 'y' or 'n'). It's up

Consider also 'm'odule support?
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
