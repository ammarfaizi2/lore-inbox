Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262163AbSJDSrs>; Fri, 4 Oct 2002 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbSJDSrs>; Fri, 4 Oct 2002 14:47:48 -0400
Received: from magic.adaptec.com ([208.236.45.80]:30939 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262163AbSJDSrq>; Fri, 4 Oct 2002 14:47:46 -0400
Date: Fri, 04 Oct 2002 12:53:03 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jure Pecar <Jure.Pecar@select-tech.si>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: aic7xxx on intel E7500 board does not work
Message-ID: <51550000.1033757582@aslan.btc.adaptec.com>
In-Reply-To: <200210041750.g94Ho1202008@stsrv.select-tech.si>
References: <200210041750.g94Ho1202008@stsrv.select-tech.si>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to test the latest 2.5.40 kernel, to see what difference does it
> make on latest hardware.
> But, it does not boot for me. It comes to scsi, detects both channels, and
> when it should start detecting disks, it outputs error messages. It works
> fine on redhat's 2.4.18-10.

Try:

http://people.FreeBSD.org/~gibbs/linux/linux-2.5-aic79xx.tar.gz

--
Justin
