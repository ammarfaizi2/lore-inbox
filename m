Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288761AbSAYQDG>; Fri, 25 Jan 2002 11:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290672AbSAYQCw>; Fri, 25 Jan 2002 11:02:52 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:43906 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S288761AbSAYQCn>;
	Fri, 25 Jan 2002 11:02:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Date: Fri, 25 Jan 2002 08:02:32 -0800
X-Mailer: KMail [version 1.3.8]
Cc: "Therien, Guy" <guy.therien@intel.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        "'lwn@lwn.net'" <lwn@lwn.net>,
        "Acpi-linux (E-mail)" <acpi-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de>
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200201250802.32508.bodnar42@phalynx.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 25, 2002 07:50, Horst von Brand wrote:
> > Given that the MS VC compiler consistently generates IA-32 code that is
> > over 30% smaller than GCC, I would have to say that Linux would benefit
> > far more by directing all of the energy spent complaining about code size
> > toward optimizing the compiler.
>
> Is it faster too? Or at least not slower? If not, what is the point?

Storing 30% less executable pages in memory?  Reading 30% less executable 
pages off the disk? Performing 30% less relocations?

-Ryan
