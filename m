Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313696AbSDQUMz>; Wed, 17 Apr 2002 16:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313712AbSDQUMy>; Wed, 17 Apr 2002 16:12:54 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:28891 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313696AbSDQUMx>; Wed, 17 Apr 2002 16:12:53 -0400
Date: Wed, 17 Apr 2002 14:10:52 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Hyperthreading
Message-ID: <1833210000.1019077852@flay>
In-Reply-To: <Pine.LNX.4.44.0204171358380.21779-100000@skuld.mtroyal.ab.ca>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That has balanced the timer irqs.  I've also enabled hyper threading
> (append="acpismp=force").
> ...
> And, you've gotta like this line:
> Total of 4 processors activated (14299.95 BogoMIPS).

Before you get too excited about that, how much performance boost do 
you actually get by turning on Hyperthreading? ;-)

M.

