Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbTI3CxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 22:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTI3CxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 22:53:11 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:18626 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263083AbTI3CxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 22:53:10 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16248.59825.930284.259695@wombat.chubb.wattle.id.au>
Date: Tue, 30 Sep 2003 12:25:53 +1000
To: Peter Osterlund <petero2@telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.0-test6: synaptics upside down? 
In-Reply-To: <Pine.LNX.4.44.0309290731120.25735-100000@telia.com>
References: <16247.49897.60412.898864@wombat.chubb.wattle.id.au>
	<Pine.LNX.4.44.0309290731120.25735-100000@telia.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Peter" == Peter Osterlund <petero2@telia.com> writes:

Peter> On Mon, 29 Sep 2003, Peter Chubb wrote:
>> Hi folks, On the latest 2.6.0-test6 kernel, the synaptics touchpad
>> on my Clevo is upside down -- moving my finger up moves the pointer
>> down, et vice versa.

Peter> Try upgrading to version 0.11.7 of the XFree86 driver.

Thanks, that fixed it.

Peter C
