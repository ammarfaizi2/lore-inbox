Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTAQQNI>; Fri, 17 Jan 2003 11:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbTAQQNH>; Fri, 17 Jan 2003 11:13:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:2060 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267560AbTAQQMH>;
	Fri, 17 Jan 2003 11:12:07 -0500
Date: Fri, 17 Jan 2003 17:21:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
       kai@tp1.ruhr-uni-bochum.de, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Message-ID: <20030117162104.GB1040@mars.ravnborg.org>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>, kai@tp1.ruhr-uni-bochum.de,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <15911.64825.624251.707026@harpo.it.uu.se> <20030117135638.A376@flint.arm.linux.org.uk> <m1adhzg3fp.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1adhzg3fp.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 09:13:14AM -0700, Eric W. Biederman wrote:
> That has been roughly my experience on x86 as well with the exception
> of bss sections.  For bss sections placing the symbols inside the section
> itself has been deadly.

Could you elaborate a bit more what you have seen?

	TIA,
		Sam
