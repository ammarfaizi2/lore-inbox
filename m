Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132789AbRDDQLN>; Wed, 4 Apr 2001 12:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132784AbRDDQLD>; Wed, 4 Apr 2001 12:11:03 -0400
Received: from ns.caldera.de ([212.34.180.1]:33540 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S132755AbRDDQKz>;
	Wed, 4 Apr 2001 12:10:55 -0400
Date: Wed, 4 Apr 2001 17:55:44 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Khalid Aziz <khalid@fc.hp.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
        Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
Message-ID: <20010404175544.A6240@caldera.de>
Mail-Followup-To: Khalid Aziz <khalid@fc.hp.com>,
	Hubertus Franke <frankeh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Mike Kravetz <mkravetz@sequent.com>,
	Fabio Riccardi <fabio@chromium.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
In-Reply-To: <OF401BD38B.CF3B1E9F-ON85256A24.0048543A@pok.ibm.com> <3ACB4156.160B7937@fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3ACB4156.160B7937@fc.hp.com>; from khalid@fc.hp.com on Wed, Apr 04, 2001 at 09:44:22AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 09:44:22AM -0600, Khalid Aziz wrote:
> Let me stress that HP scheduler is not meant to be a replacement for the
> current scheduler. The HP scheduler patch allows the current scheduler
> to be replaced by another scheduler by loading a module in special
> cases.

HP also has a simple mq patch that is _not_ integrated into the pluggable
scheduler framework, I have used it myself.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
