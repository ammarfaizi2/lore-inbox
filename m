Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbSJLIsE>; Sat, 12 Oct 2002 04:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262405AbSJLIsE>; Sat, 12 Oct 2002 04:48:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9232 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262397AbSJLIsE>; Sat, 12 Oct 2002 04:48:04 -0400
Date: Sat, 12 Oct 2002 09:53:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: dilinger@mp3revolution.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] sparc64 makefile dep fix for uart_console_init
Message-ID: <20021012095348.A12955@flint.arm.linux.org.uk>
References: <20021012082405.GB10000@chunk.voxel.net> <20021012.013507.27779687.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021012.013507.27779687.davem@redhat.com>; from davem@redhat.com on Sat, Oct 12, 2002 at 01:35:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 01:35:07AM -0700, David S. Miller wrote:
> Probably a fix could be to add CONFIG_SERIAL_SUNCORE to the
> checks that set CONFIG_SERIAL_CORE, I think that's how I'll
> fix this.

Agreed.  Do you want me to make the change?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

