Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbVIZOcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbVIZOcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbVIZOcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:32:22 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:51345 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751631AbVIZOcW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:32:22 -0400
Subject: Re: AIO Support and related package information??
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <20050926140613.75109.qmail@web8402.mail.in.yahoo.com>
References: <20050926140613.75109.qmail@web8402.mail.in.yahoo.com>
Date: Mon, 26 Sep 2005 16:34:09 +0200
Message-Id: <1127745249.2069.30.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/09/2005 16:45:33,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/09/2005 16:45:36,
	Serialize complete at 26/09/2005 16:45:36
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 15:06 +0100, vikas gupta wrote:
> Hi Sebastien
> 
> Thanks for Your reply .. I am now trying for that
> Sysbench ..
> 
> In the mean time i have executed test cases that are
> under check folder in libposix package ...
> Well I am getting following result ...
> ----------------------------------------------------
 ...
> Apart from that two test cases aio_read_one_thread_id
> and aio_write_one_thread_id are hanging ...
> 
> Can You please justify this behaviour ....
> As most of the testcases are giving either
> error(Invalid Argument ..) 

  These results are normal if you has none of the aio patches
applied.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

