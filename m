Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313501AbSDGXGO>; Sun, 7 Apr 2002 19:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313502AbSDGXGN>; Sun, 7 Apr 2002 19:06:13 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:8210 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S313501AbSDGXGM>;
	Sun, 7 Apr 2002 19:06:12 -0400
Date: Mon, 8 Apr 2002 00:06:01 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407230559.GA26228@compsoc.man.ac.uk>
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk> <E16uIf7-0006Zw-00@the-village.bc.nu> <20020407194114.GA21800@compsoc.man.ac.uk> <m1y9fzmfr1.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16uLja-000Bng-00*gzZuzm/Br8g* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 02:10:42PM -0600, Eric W. Biederman wrote:

> Deep technical reason there are architectures where patching the
> system call table does not work.

Everyone knows that. This is just one of the reasons it will never be
*encouraged*, not a reason for disabling it (when it doesn't hurt to
leave it as is).

regards
john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
