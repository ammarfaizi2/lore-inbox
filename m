Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313776AbSDHV7K>; Mon, 8 Apr 2002 17:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313774AbSDHV7I>; Mon, 8 Apr 2002 17:59:08 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22150 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313772AbSDHV7E>; Mon, 8 Apr 2002 17:59:04 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 8 Apr 2002 15:05:41 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: system call for finding the number of cpus??
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A44520@tayexc13.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.44.0204081504080.1498-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Kuppuswamy, Priyadarshini wrote:

> I don't think that (sysconf(_SC_NPROCESSORS_CONF)) command works on
> linux. It works on Unix. I tried that. It returns 1 when there are 4
> processors on linux.

it always worked fine for me, up to 8 CPUs ...




- Davide


