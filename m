Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289348AbSA3QD0>; Wed, 30 Jan 2002 11:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289347AbSA3QDR>; Wed, 30 Jan 2002 11:03:17 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:2746 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289341AbSA3QC7>; Wed, 30 Jan 2002 11:02:59 -0500
Date: Wed, 30 Jan 2002 17:57:51 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Michel Angelo da Silva Pereira <michelpereira@uol.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.18-pre3-ac2 with Intel ServerRAID Controller
In-Reply-To: <Pine.LNX.4.44.0201301602510.2726-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0201301756530.5518-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please try without the adaptec i2o driver compiled in and only 
the generic i2o drivers. Also which kernel last worked for you?

Cheers,
	Zwane Mwaikambo


