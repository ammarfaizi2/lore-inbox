Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSCLSHb>; Tue, 12 Mar 2002 13:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311303AbSCLSHV>; Tue, 12 Mar 2002 13:07:21 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31648 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311264AbSCLSHN>; Tue, 12 Mar 2002 13:07:13 -0500
Date: Tue, 12 Mar 2002 10:06:25 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: walter <walt@nea-fast.com>, linux-kernel@vger.kernel.org
Subject: Re: oracle rmap kernel version
Message-ID: <177640000.1015956385@flay>
In-Reply-To: <200203121729.MAA08522@int1.nea-fast.com>
In-Reply-To: <200203121729.MAA08522@int1.nea-fast.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone have any production experience running Oracle 8i on Linux? I've 
> run it at home, RH 7.2 with vanilla 2.4.16 kernel all IDE drives, and its 
> fast. We are replacing our SUN/Oracle 8 servers at work in next couple of 
> months with Linux/Oracle 8i (Pentium 4 1GB ram).  My question is, what is the 
> best kernel version to use,  vanilla 2.4.x or a RH kernel built from the ac 
> tree with rmap. All drives will be SCSI. 
> I read an interview yesterday with Rik van Riel where he said rmap worked 
> better for db servers but I expect that he is partial to rmap 8-).
> Our web servers are running vanilla 2.4.16 and we haven't had a problem yet 
> (knock on wood).

The real answer is to try them and do a benchmark for your particular
application. Shouldn't take that long .... try the -aa tree too.

Martin.

