Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUBGHl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 02:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUBGHl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 02:41:59 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:28820 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S266684AbUBGHl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 02:41:58 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: FATAL: Kernel too old
Date: Sat, 7 Feb 2004 07:41:56 +0000
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.53.0402061550440.681@chaos>
In-Reply-To: <Pine.LNX.4.53.0402061550440.681@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402070741.56848.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen this message when trying to use a glibc configured with
        --enable-kernel=2.4.20
on a machine running a 2.4.19 kernel.

You haven't either upgraded glibc or started using an older kernel, have you?

Andrew

