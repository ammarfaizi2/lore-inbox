Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284956AbRLUSpW>; Fri, 21 Dec 2001 13:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284963AbRLUSpJ>; Fri, 21 Dec 2001 13:45:09 -0500
Received: from aldebaran.sra.com ([163.252.31.31]:4014 "EHLO aldebaran.sra.com")
	by vger.kernel.org with ESMTP id <S284956AbRLUSpB>;
	Fri, 21 Dec 2001 13:45:01 -0500
From: David Garfield <garfield@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15395.33489.779730.767039@irving.iisd.sra.com>
Date: Fri, 21 Dec 2001 13:43:29 -0500
To: esr@thyrsus.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <20011220185226.A25080@thyrsus.com>
In-Reply-To: <20011220143247.A19377@thyrsus.com>
	<15394.29882.361540.200600@irving.iisd.sra.com>
	<20011220185226.A25080@thyrsus.com>
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond writes:
 > David Garfield <garfield@irving.iisd.sra.com>:
 > > Another option: maybe the choice of KB vs KiB vs KKB should be a
 > > configuration choice.
 > 
 > You *must* be joking.
 > 
 > Please tell me you're joking.

No, I'm serious.  I will understand if CML2 does not support
meta-configuration.  A configuration choice as I described above could
be viewed as a minor facet of a language configuration choice.
(Should kernel configuration be internationalized or at least
internationalizable?)

Choice of kB vs KB vs KiB vs KKB could also be used in some places in
the kernel.  For instance, /proc/meminfo currently shows "kB".

--David
