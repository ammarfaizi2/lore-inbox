Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279849AbRJ3EYA>; Mon, 29 Oct 2001 23:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279853AbRJ3EXv>; Mon, 29 Oct 2001 23:23:51 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57589
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279849AbRJ3EXk>; Mon, 29 Oct 2001 23:23:40 -0500
Date: Mon, 29 Oct 2001 20:24:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: George Garvey <tmwg-linuxknl@inxservices.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
Message-ID: <20011029202411.I20280@mikef-linux.matchmail.com>
Mail-Followup-To: George Garvey <tmwg-linuxknl@inxservices.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011028204003.A1640@lightning.swansea.linux.org.uk> <20011029200947.C14203@inxservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011029200947.C14203@inxservices.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 08:09:47PM -0800, George Garvey wrote:
> (except for nVidia driver module).

You can kiss any useful support from this group if any binary kernel modules
have *ever* touched the kernel you run.

However, if you can reproduce the same problem without any binary modules
*ever* being loaded since the last reboot, then you will probably get support.

*ever* includes loading and then unloading a binary module within the
current session.  Session being the entire time a kernel runs without being
rebooted.

Mike
