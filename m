Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290645AbSAYQQM>; Fri, 25 Jan 2002 11:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290712AbSAYQQC>; Fri, 25 Jan 2002 11:16:02 -0500
Received: from ns.suse.de ([213.95.15.193]:42758 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290645AbSAYQPu> convert rfc822-to-8bit;
	Fri, 25 Jan 2002 11:15:50 -0500
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Therien, Guy" <guy.therien@intel.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        "'lwn@lwn.net'" <lwn@lwn.net>,
        "Acpi-linux (E-mail)" <acpi-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de>
	<200201250802.32508.bodnar42@phalynx.dhs.org>
X-Yow: If I am elected no one will ever have to do their laundry again!
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 25 Jan 2002 17:15:46 +0100
In-Reply-To: <200201250802.32508.bodnar42@phalynx.dhs.org> (Ryan Cumming's
 message of "Fri, 25 Jan 2002 08:02:32 -0800")
Message-ID: <jeelkes8y5.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming <bodnar42@phalynx.dhs.org> writes:

|> On January 25, 2002 07:50, Horst von Brand wrote:
|> > > Given that the MS VC compiler consistently generates IA-32 code that is
|> > > over 30% smaller than GCC, I would have to say that Linux would benefit
|> > > far more by directing all of the energy spent complaining about code size
|> > > toward optimizing the compiler.
|> >
|> > Is it faster too? Or at least not slower? If not, what is the point?
|> 
|> Storing 30% less executable pages in memory?  Reading 30% less executable 
|> pages off the disk?

These are all startup costs that are lost in the noise the longer the
program runs.

|> Performing 30% less relocations?

30% less code does not imply 30% less relocations.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
