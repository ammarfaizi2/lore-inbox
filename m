Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270629AbRHNPVg>; Tue, 14 Aug 2001 11:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270632AbRHNPV0>; Tue, 14 Aug 2001 11:21:26 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:62733 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S270629AbRHNPVR>; Tue, 14 Aug 2001 11:21:17 -0400
Date: Tue, 14 Aug 2001 16:21:28 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: List of kernel func. in INT80
Message-ID: <20010814162128.C9798@compsoc.man.ac.uk>
In-Reply-To: <E15WY8e-000Er1-00@f3.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15WY8e-000Er1-00@f3.mail.ru>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 10:57:20AM +0400, Samium Gromoff wrote:

>          Where one can find a place with systematically
>       updated list of mappings of kernel functions
>       to int 80 numbers?
>    thanks in advance...

arch/i386/kernel/entry.S

john

-- 
"Not to laugh, not to lament, not to curse, but to understand."
	- Spinoza
