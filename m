Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279683AbRJYCYN>; Wed, 24 Oct 2001 22:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279684AbRJYCYD>; Wed, 24 Oct 2001 22:24:03 -0400
Received: from [194.46.8.33] ([194.46.8.33]:46091 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S279683AbRJYCXv>;
	Wed, 24 Oct 2001 22:23:51 -0400
Date: Thu, 25 Oct 2001 03:27:41 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Defaulting new questions in scripts/Configure?
Message-ID: <20011025032741.K24348@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just skimmed through the code in Configure to
see if there is a way to make it shut up and just
default everything new to NO so I can use it inside
a noninteractive script.

Did I miss it or is it something that isn't there
to be found?

I think I'd not be the only one to find it useful
to make it be seen and not heard during a 
make oldconfig :-)

-- 
------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------
