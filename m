Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUDLMZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUDLMZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 08:25:59 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36035 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262882AbUDLMZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 08:25:58 -0400
Date: Mon, 12 Apr 2004 08:26:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "osmaker@hu" <osmaker@mailbox.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic
In-Reply-To: <461730575.20040412183950@mailbox.hu>
Message-ID: <Pine.LNX.4.58.0404120824430.16677@montezuma.fsmlabs.com>
References: <461730575.20040412183950@mailbox.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, osmaker@hu wrote:

> Hello everyone,
> I have got a kernel panic when running a heavy load socket processing.
> This server is written by my self and when the clients reached 10k,
> the panic occured. In the server code run 100 threads and every thread
> using poll on fds.
>       I am a newbie on kernel ,can you tell me how to solve the
>       problem?and how to analyze the panic when I come across it?

I recommend you upgrade your Redhat kernel (the one you're running is
pretty old) and if the problem still persists, file a bugreport at
http://bugzilla.redhat.com

	Zwane
