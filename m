Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTIDCRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTIDCRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:17:54 -0400
Received: from holomorphy.com ([66.224.33.161]:14476 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264493AbTIDCRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:17:52 -0400
Date: Wed, 3 Sep 2003 19:18:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Steven Cole <elenstev@mesatop.com>, Antonio Vargas <wind@cocodriloo.com>,
       Larry McVoy <lm@bitmover.com>, CaT <cat@zip.com.au>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030904021819.GD4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>,
	Steven Cole <elenstev@mesatop.com>,
	Antonio Vargas <wind@cocodriloo.com>, Larry McVoy <lm@bitmover.com>,
	CaT <cat@zip.com.au>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <20030903124716.GE2359@wind.cocodriloo.com> <1062603063.1723.91.camel@spc9.esa.lanl.gov> <200309040350.31949.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309040350.31949.phillips@arcor.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 03:50:31AM +0200, Daniel Phillips wrote:
> Bill Irwin how his 32 node Numa cluster is running these days).  This blows 

Sorry for any misunderstanding, the model only goes to 16 nodes/64x,
the box mentioned was 32 cpus. It's also SMP (SSI, shared memory,
mach-numaq), not a cluster. I also only have half of it full-time.


-- wli
