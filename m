Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbSLSAXW>; Wed, 18 Dec 2002 19:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbSLSAXV>; Wed, 18 Dec 2002 19:23:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5098
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267430AbSLSAXU>; Wed, 18 Dec 2002 19:23:20 -0500
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 
	Promise ctrlr, or...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "D.A.M. Revok" <marvin@synapse.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       support@promise.com
In-Reply-To: <200212181703.18647.marvin@synapse.net>
References: <Pine.LNX.4.10.10212180241580.8350-100000@master.linux-ide.org>
	<200212181635.58164.marvin@synapse.net>
	<1040251122.26501.0.camel@irongate.swansea.linux.org.uk> 
	<200212181703.18647.marvin@synapse.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Dec 2002 01:11:51 +0000
Message-Id: <1040260311.26882.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 22:03, D.A.M. Revok wrote:
> Then I'm not buying Promise from now on.  Period.
> 
> Being non-able to both 
> boot-from-SCSI-CDR, and
> use smartctl
> is non-acceptable, and if their NDAs rig that then they are a threat 
> against /everything/ I base on my systems.
> 
> Promise, your business-model damages your customer-relationship's 
> survival, are you listening

Those kind of NDA's are quite normal. You'll see them elsewhere too. You
get this maze of NDA's between vendors about hardware flaws. So promise 
might do a workaround for an ibm disk but have NDA's with IBM that says
they can't tell people. (Thats an example I'm not saying there is a real
IBM case)

Ditto with AGP and AMD for example. They have magic fixup registers for
timings, but won't tell us the fixups for various vendors cards (which
is dumb because its not hard to find out in windows!)


