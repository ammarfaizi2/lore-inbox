Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281537AbRKQAhN>; Fri, 16 Nov 2001 19:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281552AbRKQAgx>; Fri, 16 Nov 2001 19:36:53 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:9733 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S281537AbRKQAgm>; Fri, 16 Nov 2001 19:36:42 -0500
Message-ID: <3BF5B10E.8A676AE0@linux-m68k.org>
Date: Sat, 17 Nov 2001 01:36:30 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, andrew.grover@intel.com
Subject: Re: 2.4.15-pre5 conflict between acpi and a.out, affs is implicated
In-Reply-To: <8705.1005956459@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Keith Owens wrote:

> Why does affs_fs_i.h include a.out.h?

No idea, it must be there since ages. affs compiles also without it, so
IMO it's not needed anymore.

bye, Roman
