Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSAZDYb>; Fri, 25 Jan 2002 22:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSAZDYV>; Fri, 25 Jan 2002 22:24:21 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:4872 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S289009AbSAZDYQ>; Fri, 25 Jan 2002 22:24:16 -0500
Date: Sat, 26 Jan 2002 03:27:27 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add BUG_ON to 2.4 #1
Message-ID: <20020126032727.GB60536@compsoc.man.ac.uk>
In-Reply-To: <1012000446.3799.77.camel@phantasy> <20020126031732.GA59924@compsoc.man.ac.uk> <1012015382.3501.269.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012015382.3501.269.camel@phantasy>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 10:22:51PM -0500, Robert Love wrote:

> Hopefully Marcelo will take this patch and we won't need BUG_ON, at
> least, for 2.5->2.4 compatibility.

we still need it in kcompat.h so I can compile under 2.4.<random>,
and 2.2.<random> for that matter.

regards
john
-- 
"ALL television is children's television."
	- Richard Adler 
