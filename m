Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263578AbRFAPag>; Fri, 1 Jun 2001 11:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263575AbRFAPa0>; Fri, 1 Jun 2001 11:30:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3231 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263582AbRFAPaP>;
	Fri, 1 Jun 2001 11:30:15 -0400
Message-ID: <3B17B506.B773B998@mandrakesoft.com>
Date: Fri, 01 Jun 2001 11:30:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ethernet still quits
In-Reply-To: <20010601151705.A526@grobbebol.xs4all.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Roeland Th. Jansen" wrote:
> when quote some xfers have taken place, the realtek card dies here.

Working on the problem.  You'll need to downgrade the 8139too driver to
the current 'ac' patches or a previous version on
http://sf.net/projects/gkernel/ temporarily.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
