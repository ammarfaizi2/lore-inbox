Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSKRKTx>; Mon, 18 Nov 2002 05:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSKRKTx>; Mon, 18 Nov 2002 05:19:53 -0500
Received: from pc311.opanet.cz ([62.77.115.11]:13453 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S261978AbSKRKTx>;
	Mon, 18 Nov 2002 05:19:53 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Mon, 18 Nov 2002 11:26:53 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Status of the CMD680 IDE driver
Message-ID: <20021118102653.GB425@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <73fe.3dd52324.188a7@gzp1.gzp.hu> <1037383237.19971.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037383237.19971.49.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 06:00:37PM +0000, Alan Cox wrote:
> On Fri, 2002-11-15 at 16:39, Gabor Z. Papp wrote:
> > Seems like it is in the later 2.4, but removed from the -ac
> > line, and missing from the 2.5 tree.
> 
> siimage driver drives the CMD680 and the SATA SII3112 version of the
> chip.

  I tried it, but performance drops from 44 MB/s to cca. 20 MB/s 
when using new seagate drive in udma5 between 2.4 and 2.5 version.

	Cheers,
		Vita
