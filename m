Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319347AbSH2VRC>; Thu, 29 Aug 2002 17:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319350AbSH2VRC>; Thu, 29 Aug 2002 17:17:02 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:7307 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S319347AbSH2VRC>; Thu, 29 Aug 2002 17:17:02 -0400
Date: Thu, 29 Aug 2002 22:34:10 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mb@jester.mews
To: Scott Edlund <scott.edlund@verizon.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Assertion failure in journal_write_metadata_buffer()
In-Reply-To: <20020829171606.B25777@verizon.com>
Message-ID: <Pine.LNX.4.44.0208292233260.7005-100000@jester.mews>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (17kWjE-0008Ol-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:16 -0400 Scott Edlund wrote:

>Assertion failure in journal_write_metadata_buffer() at journal.c:406
[snip]
>EIP is at journal_write_metadata_buffer [jbd] 0x74 (2.4.18-3smp)

Try the latest RH errata kernel--this should fix it.

