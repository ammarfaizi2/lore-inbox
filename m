Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283228AbRLDRqt>; Tue, 4 Dec 2001 12:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283221AbRLDRpT>; Tue, 4 Dec 2001 12:45:19 -0500
Received: from ns.caldera.de ([212.34.180.1]:17607 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283218AbRLDRor>;
	Tue, 4 Dec 2001 12:44:47 -0500
Date: Tue, 4 Dec 2001 18:43:51 +0100
From: Christoph Hellwig <hch@caldera.de>
To: dalecki@evision.ag
Cc: esr@thyrsus.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204184351.A15714@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>, dalecki@evision.ag,
	esr@thyrsus.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
In-Reply-To: <20011204173309.A10746@emma1.emma.line.org> <E16BJ9v-0002ii-00@the-village.bc.nu> <20011204121950.E16578@thyrsus.com> <3C0D0845.6FA6FBFD@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0D0845.6FA6FBFD@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Dec 04, 2001 at 06:30:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:30:45PM +0100, Martin Dalecki wrote:
> ~# rpm -qa | grep -i python
> python-1.5.2-35
> python-xmlrpc-1.5.0-1
> pythonlib-1.28-1
> rpm-python-4.0.3-1.03
> python-devel-1.5.2-35
> 
> Just another megaton unnecessary programming language to compile
> somehting like the kernel? I think you are exaggerating the problem.

Same here (A few weeks old Caldera development snapshot):

[hch@sb hch]$ rpm -qa | grep python
dcoppython-2.2.1-2
python-1.5.2-8
python-devel-1.5.2-8
python-doc-1.5.2-8
python-eclass-1.2-6
python-tk-1.5.2-8


