Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbSAARQu>; Tue, 1 Jan 2002 12:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbSAARQd>; Tue, 1 Jan 2002 12:16:33 -0500
Received: from h24-71-223-13.cg.shawcable.net ([24.71.223.13]:33946 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S282597AbSAARPs>; Tue, 1 Jan 2002 12:15:48 -0500
Date: Tue, 01 Jan 2002 10:15:41 -0700 (MST)
From: Tim Keating <tkeating@shaw.ca>
Subject: Re: Another .text.exit error. 2.4.18pre1
In-Reply-To: <4450.1009881110@ocs3.intra.ocs.com.au>
X-X-Sender: <tkeating@darkspace.hidden.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.33.0201011011510.144-100000@darkspace.hidden.net>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002, Keith Owens wrote:

>
> If you can do without nat for snmp then CONFIG_IP_NF_NAT_SNMP_BASIC=n.
> Otherwise look for a patch with subject
>   [patch] 2.4.18-pre1 replace .text.lock with .subsection
> With any luck that patch will be in 2.4.18-pre2.
>

Sure.  Just doing some testing here, so I can live without it.

Thanks for taking a few moments to reply to my report.

Tim

-- 
If you want to speak to someone knowledgeable about computers and who
knows what's going on in "the local computer store", then you are forced
to talk to yourself... (;-))

