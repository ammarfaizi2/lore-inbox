Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbREQH2N>; Thu, 17 May 2001 03:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbREQH2F>; Thu, 17 May 2001 03:28:05 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:27663 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261294AbREQH1p>;
	Thu, 17 May 2001 03:27:45 -0400
Date: Thu, 17 May 2001 03:26:36 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Jes Sorensen <jes@sunsite.dk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010517032636.A1109@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Pavel Machek <pavel@suse.cz>, Jes Sorensen <jes@sunsite.dk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <20010515144325.A38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010515144325.A38@toy.ucw.cz>; from pavel@suse.cz on Tue, May 15, 2001 at 02:43:27PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz>:
> And If I want scsi-on-atapi emulation but not vme147_scsi?

Help me understand this case, please.  What is scsi-on-atapi?
Is SCSI on when you enable it?  And is it a realistic case for an SBC?

The CML2 constraint language is very flexible.  I can make it do the
right thing, if I know what the right thing is.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Where rights secured by the Constitution are involved, there can be no
rule making or legislation which would abrogate them.
        -- Miranda vs. Arizona, 384 US 436 p. 491
