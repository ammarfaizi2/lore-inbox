Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbREWADV>; Tue, 22 May 2001 20:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262910AbREWADL>; Tue, 22 May 2001 20:03:11 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25763 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262903AbREWAC4>;
	Tue, 22 May 2001 20:02:56 -0400
Message-ID: <3B0AFE0C.8392E7C4@mandrakesoft.com>
Date: Tue, 22 May 2001 20:02:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, viro@math.psu.edu, axboe@suse.de
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105222217.AAA79157.aeb@vlet.cwi.nl> <3B0AEC76.F5B425F5@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO it would be nice to (for 2.4) create wrappers for accessing the
block arrays, so that we can more easily dispose of the arrays when 2.5
rolls around...
-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
