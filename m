Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTIDCeB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTIDCeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:34:00 -0400
Received: from holomorphy.com ([66.224.33.161]:20876 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264479AbTIDCd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:33:58 -0400
Date: Wed, 3 Sep 2003 19:35:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Daniel Phillips <phillips@arcor.de>, Antonio Vargas <wind@cocodriloo.com>,
       Larry McVoy <lm@bitmover.com>, CaT <cat@zip.com.au>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030904023501.GE4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Steven Cole <elenstev@mesatop.com>,
	Daniel Phillips <phillips@arcor.de>,
	Antonio Vargas <wind@cocodriloo.com>, Larry McVoy <lm@bitmover.com>,
	CaT <cat@zip.com.au>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <20030903124716.GE2359@wind.cocodriloo.com> <1062603063.1723.91.camel@spc9.esa.lanl.gov> <200309040350.31949.phillips@arcor.de> <1062641965.3483.78.camel@spc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062641965.3483.78.camel@spc>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:19:26PM -0600, Steven Cole wrote:
> I would never call the SMP locking pathetic, but it could be improved.
> Looking at Figure 6 (Star-CD, 1-64 processors on Altix) and Figure 7
> (Gaussian 1-32 processors on Altix) on page 13 of "Linux Scalability for
> Large NUMA Systems", available for download here:
> http://archive.linuxsymposium.org/ols2003/Proceedings/
> it appears that for those applications, the curves begin to flatten
> rather alarmingly.  This may have little to do with locking overhead.

Those numbers are 2.4.x


-- wli
