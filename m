Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132537AbRDGEbX>; Sat, 7 Apr 2001 00:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbRDGEbO>; Sat, 7 Apr 2001 00:31:14 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:22265
	"EHLO vaio.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132537AbRDGEa4>; Sat, 7 Apr 2001 00:30:56 -0400
Message-ID: <3ACE97E0.B95A5748@linux-ide.org>
Date: Fri, 06 Apr 2001 21:30:24 -0700
From: Andre Hedrick <andre@linux-ide.org>
Organization: Linux ATA Development
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank.Cornelis@rug.ac.be, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.3 crashed my hard disk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You killed yourself....

You do not have a host that will do idebus=66
You have now dived you clock timing in half.
You should expect to have a driver time out before the device is
completed.

-- 
Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com
