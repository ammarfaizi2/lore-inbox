Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbRL0Wbk>; Thu, 27 Dec 2001 17:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282919AbRL0Wbb>; Thu, 27 Dec 2001 17:31:31 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:7748 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S282902AbRL0WbO>;
	Thu, 27 Dec 2001 17:31:14 -0500
Message-ID: <20011227233112.A4528@win.tue.nl>
Date: Thu, 27 Dec 2001 23:31:12 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: andersg@0x63.nu, linux-kernel@vger.kernel.org
Subject: Re: kiB
In-Reply-To: <20011227160557.GB11106@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20011227160557.GB11106@h55p111.delphi.afb.lu.se>; from andersg@0x63.nu on Thu, Dec 27, 2001 at 05:05:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 05:05:57PM +0100, andersg@0x63.nu wrote:
> this shouldn't be that controversial, as it's only visible to people
> compiling kernels :)

> +	fprintf (stderr, "System is %d kiB\n", sz/1024);

But if you want to change things to conform, do so.
The unit is Ki, not ki.
