Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUCQStI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUCQStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:49:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30349 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261169AbUCQStF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:49:05 -0500
Date: Wed, 17 Mar 2004 13:50:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: VINOD GOPAL <vinod_gopal74@yahoo.com>
cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: arithmetic functions for linux driver
In-Reply-To: <20040317181537.43286.qmail@web60709.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0403171338500.19593@chaos>
References: <20040317181537.43286.qmail@web60709.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, VINOD GOPAL wrote:

> The range of input is varying.
> Iam looking for floating point arithmetic functions
> like log10, pow , sin ,exp , cos etc.
>

Like the range of input from an ADC? You get the data in
the kernel and you muck with it in user-mode after you
have it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


