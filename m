Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262627AbTDAQNk>; Tue, 1 Apr 2003 11:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbTDAQNk>; Tue, 1 Apr 2003 11:13:40 -0500
Received: from smtpde01.sap-ag.de ([155.56.68.140]:2782 "EHLO
	smtpde01.sap-ag.de") by vger.kernel.org with ESMTP
	id <S262627AbTDAQNf>; Tue, 1 Apr 2003 11:13:35 -0500
From: Christoph Rohland <cr@sap.com>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'tomlins@cam.org'" <tomlins@cam.org>, "'CaT'" <cat@zip.com.au>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Organisation: Development SAP J2EE Engine
Date: Tue, 01 Apr 2003 18:24:16 +0200
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE982@mailse01.se.axis.com> (Mikael
 Starvik's message of "Tue, 1 Apr 2003 16:22:18 +0200")
Message-ID: <ovn0jakwy7.fsf@sap.com>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.4 (Native Windows TTY
 Support (Windows), cygwin32)
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE982@mailse01.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael,

On Tue, 1 Apr 2003, Mikael Starvik wrote:
> All systems that uses tmpfs doesn't necessairly have a swap, 
> tmpfs is used in several diskless embedded systems.

But on these systems you better use ramfs.

Greetings
		Christoph


