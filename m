Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbUJ0Sxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUJ0Sxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbUJ0SxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:53:20 -0400
Received: from ip189.73.1311O-CUD12K-02.ish.de ([62.143.73.189]:29314 "EHLO
	sheridan") by vger.kernel.org with ESMTP id S262518AbUJ0Sr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:47:57 -0400
From: Marcus Metzler <mocm@mocm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16767.60737.698046.41257@mocm.de>
Date: Wed, 27 Oct 2004 20:47:29 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paulo Marques <pmarques@grupopie.com>, Lee Revell <rlrevell@joe-job.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
In-Reply-To: <1098894142.4304.26.camel@localhost.localdomain>
References: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com>
	<417FB7BA.9050005@grupopie.com>
	<1098892587.8313.5.camel@krustophenia.net>
	<417FC96B.8030402@grupopie.com>
	<1098894142.4304.26.camel@localhost.localdomain>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: mocm@mocm.de
X-Face: X!$Vwl\?,AW_[zm^ej\MLxN>q;R?C_sRZ*XE4V;BGT28Ewyd\:TS')W'G#Dgay8ci$*{lEd
 02(Nk0OndG\752U>lozmb_R1poDm6mgHm_4.}bdS0hh.`xGUI.X2x_50T9.?_v~.,QI*$2:Q=HV@>F
 IP6%l~E:T|w,X[eC;|YD(A9X'sS"r$l]g<4CjAm4|f7o0>6zGwUPLinP0.d=E+_%?4>0A9'esEZ=9h
 $#b[g*/q/g'GVj-hDc,+V_]1.H^N,1Bju,>5FZn"B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    Alan> On Mer, 2004-10-27 at 17:14, Paulo Marques wrote:
    >> > Why don't you try the VIA EPIA mini-ITX boards?  These are
    >> designed for > low power applications like yours.  I am running
    >> the M-6000 which has a > fanless 600Mhz C3 processor, the newer
    >> fanless models run at 1Ghz.  And, > on top of that they support
    >> speed scaling so you can slow it down even > more.
    >> 
    >> Yes, we tried those, but floating point calculations completely
    >> kill the performance on those boards.

    Alan> You want Geode/NX or Pentium-M ITX boards for that (or the
    Alan> low power 'Shelton' board although you may need to import
    Alan> that since its only sold in "poor countries")

    Alan> Agree with you on pricing though.

You could also try the Efficeon board by ibase
(http://www.ibase.com.tw/mb860.htm). There seem to be some resellers
http://mb860f.4t.com/. And it has some good reviews
http://www.epiacenter.com/modules.php?name=Content&pa=showpage&pid=52
with the only disadvantage being the price.

Marcus

-- 
/--------------------------------------------------------------------\
| Dr. Marcus O.C. Metzler        |                                   |
| mocm@metzlerbros.de            | http://www.metzlerbros.de/        |
\--------------------------------------------------------------------/
 |>>>             Quis custodiet ipsos custodies                 <<<|
