Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbRADSLa>; Thu, 4 Jan 2001 13:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131070AbRADSLU>; Thu, 4 Jan 2001 13:11:20 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:48909
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129834AbRADSLB>; Thu, 4 Jan 2001 13:11:01 -0500
Date: Fri, 5 Jan 2001 07:10:53 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Lang <david.lang@digitalinsight.com>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010105071053.A31025@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.31.0101040942550.10387-100000@dlang.diginsite.com> <E14EEfY-00067i-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14EEfY-00067i-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 04, 2001 at 05:59:17PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    In the embedded world you will regularly see adherence to that
    model in the specification. Firstly because the users do it,
    secondly because power cuts ensure it happens anyway

With ACPI you should be able to hook things like the off button and
make it do the right thing. This more like what your video and TV do,
as opposed to your toaster.

The off button need not and _does not_ remove power instantly (if at
all) on many appliances.



  --cw

P.S. Yeah, I'm making a few assumptions about your appliances. but
     I'm sure you know what I mean.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
