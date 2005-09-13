Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVIMQrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVIMQrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVIMQrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:47:21 -0400
Received: from 216-54-166-16.gen.twtelecom.net ([216.54.166.16]:58330 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S964875AbVIMQrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:47:20 -0400
Message-ID: <43270294.9010509@compro.net>
Date: Tue, 13 Sep 2005 12:47:16 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: HZ question
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com> <4326DB8A.7040109@compro.net> <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de> <4326EAD7.50004@compro.net> <Pine.LNX.4.53.0509131750580.15000@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0509131750580.15000@gockel.physik3.uni-rostock.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.12.33
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:

> Do you also want to know about CONFIG_PREEMPT, SMP, current load, future
> load in order to estimate the delay you want to ask for?

Are not CONFIG_PREEMPT, SMP, and current load, all determinable from 
userland anyway? Why not HZ?

Mark

