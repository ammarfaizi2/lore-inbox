Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbREOJPb>; Tue, 15 May 2001 05:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbREOJPL>; Tue, 15 May 2001 05:15:11 -0400
Received: from [62.172.234.2] ([62.172.234.2]:56361 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S262698AbREOJPD>;
	Tue, 15 May 2001 05:15:03 -0400
Date: Tue, 15 May 2001 10:14:47 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Blesson Paul <blessonpaul@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: dget()
In-Reply-To: <989917611.27689.9.camel@nomade>
Message-ID: <Pine.LNX.4.21.0105151012470.1705-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2001, Xavier Bestel wrote:
> # cd /usr/src/linux
> # make tags

No, I never use that one because it skips very useful entries like the
ones from EXPORT_SYMBOL etc. Also, it only shows the current architecture.
So, the tags target in the Makefile would only become useful when it is
stripped of extra (unnecessary, imho) logic and turned into a plain one I
suggested above.

Regards,
Tigran

