Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUITTBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUITTBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUITTBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:01:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13696 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266674AbUITTBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:01:23 -0400
Date: Mon, 20 Sep 2004 15:00:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stelian Pop <stelian@popies.net>
cc: Sasha Khapyorsky <sashak@smlink.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <20040920182238.GA2795@crusoe.dsnet>
Message-ID: <Pine.LNX.4.53.0409201457130.1244@chaos>
References: <20040917154834.GA3180@crusoe.alcove-fr>
 <Pine.LNX.4.44.0409171708210.3162-100000@localhost.localdomain>
 <20040917205011.GA3049@crusoe.dsnet> <20040917212847.GC15426@dualathlon.random>
 <20040920151425.GA3020@crusoe.alcove-fr> <20040920210134.0b4af72c@sashak.lan>
 <20040920182238.GA2795@crusoe.dsnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why __kfifo_put ?
    __kfifo_get ?
    ^^__________  Usually reserved for weak (hidden) references

in header files.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

