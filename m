Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288531AbSAQLgJ>; Thu, 17 Jan 2002 06:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288534AbSAQLf7>; Thu, 17 Jan 2002 06:35:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61964 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288531AbSAQLfy>;
	Thu, 17 Jan 2002 06:35:54 -0500
Message-ID: <3C46B718.26F52BD5@mandrakesoft.com>
Date: Thu, 17 Jan 2002 06:35:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
In-Reply-To: <20020117015456.A628@thyrsus.com> <20020117121723.B22171@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Thu, Jan 17, 2002 at 01:54:56AM -0500, Eric S. Raymond wrote:
>  > Does anything in /proc or elswhere reliably register the presence of EISA?
> 
>  Not afaik. I'm tempted to hack support for it into driverfs.

The EISA_bus global variable indicates presence...

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
