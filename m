Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265405AbRFYHUS>; Mon, 25 Jun 2001 03:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbRFYHUH>; Mon, 25 Jun 2001 03:20:07 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:1516 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S265405AbRFYHTx>; Mon, 25 Jun 2001 03:19:53 -0400
From: Christoph Rohland <cr@sap.com>
To: Allan Duncan <allan.d@bigpond.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Shared memory quantity not being reflected by /proc/meminfo
In-Reply-To: <200106240249.f5O2nIF07215@saturn.cs.uml.edu>
	<m3n16yjmkl.fsf@linux.local> <3B35DC3D.6D2DC9C@bigpond.com>
Organisation: SAP LinuxLab
Date: 25 Jun 2001 09:01:54 +0200
In-Reply-To: <3B35DC3D.6D2DC9C@bigpond.com>
Message-ID: <m3els9jb4t.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allan,

On Sun, 24 Jun 2001, Allan Duncan wrote:
> OK, it's fine by me if the "shared" under 2.2.x is not the same,
> however in that case the field should not appear at all in meminfo,
> rather than the current zero value, which leads lesser kernel
> hackers like me up the garden path.

This would probably break a lot of user space apps.

Greetings
		Christoph


