Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268147AbUBRVXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUBRVXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:23:32 -0500
Received: from [212.28.208.94] ([212.28.208.94]:56338 "HELO dewire.com")
	by vger.kernel.org with SMTP id S268147AbUBRVXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:23:00 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Date: Wed, 18 Feb 2004 22:22:51 +0100
User-Agent: KMail/1.6.1
Cc: Tomas Szepe <szepe@pinerecords.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <20040218194744.GB1537@louise.pinerecords.com> <4033C48E.8020409@zytor.com>
In-Reply-To: <4033C48E.8020409@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402182222.51110.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 February 2004 21.01, H. Peter Anvin wrote:
> [And e.g. \U00017777 for characters above \uFFFF]

Isn't that octal :-)

-- robin
