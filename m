Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288537AbSADIDp>; Fri, 4 Jan 2002 03:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288534AbSADICx>; Fri, 4 Jan 2002 03:02:53 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:3859 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S288533AbSADICm>;
	Fri, 4 Jan 2002 03:02:42 -0500
Date: Thu, 3 Jan 2002 23:40:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Henderson <rth@redhat.com>, Tom Rini <trini@kernel.crashing.org>,
        Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103234046.B12380@elf.ucw.cz>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102142712.B10474@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102142712.B10474@redhat.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, the problem is that we aren't running where the compiler thinks we
> > are yet.  So what would the right fix be for this?
> 
> Assembly.

Is there problem with doing what Jakub suggested?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
