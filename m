Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRB0KKT>; Tue, 27 Feb 2001 05:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbRB0KKA>; Tue, 27 Feb 2001 05:10:00 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:2575 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129669AbRB0KJs>; Tue, 27 Feb 2001 05:09:48 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: rsaura@retevision.es
cc: linux-kernel@vger.kernel.org
Message-ID: <CA256A00.00373D64.00@d73mta05.au.ibm.com>
Date: Tue, 27 Feb 2001 15:25:09 +0530
Subject: Re: increasing the number of file descriptors
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 >     While I'm seriouly looking for a fd-leak in the php-development
  >    behind the web server, I realized that i didn't know how to increase
  >    this parameter.

>      Is there any /proc interface for increasing the number of file
 >     descriptors per process?

Yes you can do it in /proc/sys/fs/file-nr

regards,
Anil


