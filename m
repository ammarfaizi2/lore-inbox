Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281239AbRLGNsM>; Fri, 7 Dec 2001 08:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281217AbRLGNsD>; Fri, 7 Dec 2001 08:48:03 -0500
Received: from ns.ithnet.com ([217.64.64.10]:38660 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281239AbRLGNrv>;
	Fri, 7 Dec 2001 08:47:51 -0500
Date: Fri, 7 Dec 2001 14:46:00 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: pablo.borges@uol.com.br, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.16 & Heavy I/O
Message-Id: <20011207144600.22652de3.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.30.0112061908220.17427-100000@mustard.heime.net>
In-Reply-To: <20011206160630.1f4ab058.pablo.borges@uol.com.br>
	<Pine.LNX.4.30.0112061908220.17427-100000@mustard.heime.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 19:10:56 +0100 (CET)
Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:

> Is it really neccecary? Free memory's a waste! The cache will be discarded
> the moment an application needs the memory.

This is not true for all cases.

Regards,
Stephan

