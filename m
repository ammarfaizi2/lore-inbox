Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289965AbSAWSry>; Wed, 23 Jan 2002 13:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289973AbSAWSrh>; Wed, 23 Jan 2002 13:47:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:20637 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289968AbSAWSrY>; Wed, 23 Jan 2002 13:47:24 -0500
Date: Wed, 23 Jan 2002 02:45:24 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Can linux support ccNUMA machine now?
Message-ID: <74750000.1011782724@flay>
In-Reply-To: <20020123003530.60778.qmail@web13903.mail.yahoo.com>
In-Reply-To: <20020123003530.60778.qmail@web13903.mail.yahoo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can linux support ccNUMA machine now? 

Yes.

> How mcuh memory linux support? 64GB or more?

Theoritically 64Gb on 32 bit machines, in practice
significantly less than that (IIRC, something like
25-30Gb). It's not terribly efficient in using it though ;-)

Martin.



