Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbTDGIy2 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTDGIy2 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:54:28 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:15061 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263347AbTDGIy1 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:54:27 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1049706146.592.8.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 11:05:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 03:18, Robert P. J. Day wrote:
>   got 2.5.66-bk12 to boot on my inspiron 8100, and ran 
> "rpm -q iptables", got the following:

Are you using RH9? Are you using rpm 4.2-0.69? If so, it's a know
problem. You should downgrade to 4.2-0.66.

________________________________________________________________________
Linux Registered User #287198

