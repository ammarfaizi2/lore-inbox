Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbTGLNLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265612AbTGLNLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:11:09 -0400
Received: from pat.uio.no ([129.240.130.16]:8093 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265597AbTGLNLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:11:07 -0400
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
References: <fa.eq8e50t.1hkoiqh@ifi.uio.no>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Sat, 12 Jul 2003 15:25:43 +0200
In-Reply-To: <fa.eq8e50t.1hkoiqh@ifi.uio.no> (Dave Jones's message of "Fri,
 11 Jul 2003 14:02:48 GMT")
Message-ID: <wxx3chb98rs.fsf@nommo.uio.no>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

  [ ... ]

> CPU frequency scaling.
> ~~~~~~~~~~~~~~~~~~~~~~
> Certain processors have the facility to scale their
> voltage/clockspeed.  2.5 introduces an interface to this feature,
> see Documentation/cpufreq for more information. This functionality
> also covers features like Intel's speedstep, and the Powernow!
> feature present in mobile AMD Athlons.  In addition to x86 variants,
> this framework also supports various ARM CPUs.  You can find a
> userspace daemon that monitors battery life and adjusts accordingly
> at: http://www.staikos.net/~staikos/cpufreqd/

  the cpufreqd project has been assimilated by a sourceforge project
  with the same name, that can be found here:
  <url: http://sourceforge.net/projects/cpufreqd/ >

  [ ... ]

-- 
Terje
