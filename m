Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966189AbWKNQe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966189AbWKNQe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966191AbWKNQe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:34:58 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:12687 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S966189AbWKNQe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:34:57 -0500
Subject: Re: [patch] floppy: suspend/resume fix
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Mikael Pettersson <mikpe@it.uu.se>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061114110958.GB2242@elf.ucw.cz>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se>
	 <20061112212941.GA31624@flint.arm.linux.org.uk>
	 <20061112220318.GA3387@elte.hu>
	 <20061112235410.GB31624@flint.arm.linux.org.uk>
	 <20061114110958.GB2242@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 11:34:21 -0500
Message-Id: <1163522062.14674.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 12:09 +0100, Pavel Machek wrote:
> Suspending with mounted floppy is a user error.

Huh?  How so?

Lee

