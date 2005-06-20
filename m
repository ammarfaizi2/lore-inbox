Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFTOem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFTOem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 10:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVFTOem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 10:34:42 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:6849 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261252AbVFTOee convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 10:34:34 -0400
Subject: Re: Pending AIO work/patches
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "suparna@in.ibm.com" <suparna@in.ibm.com>
Cc: "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       bcrl@kvack.org, wli@holomorphy.com, zab@zabbo.net, mason@suse.com,
       ysaito@hpl.hp.com
In-Reply-To: <20050620120154.GA4810@in.ibm.com>
References: <20050620120154.GA4810@in.ibm.com>
Date: Mon, 20 Jun 2005 16:32:57 +0200
Message-Id: <1119277977.1421.16.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2005 16:45:20,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2005 16:45:52,
	Serialize complete at 20/06/2005 16:45:52
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 17:31 +0530, Suparna Bhattacharya wrote:
> (3) POSIX AIO support (Bull: Laurent/Sebastian or Oracle: Joel)
> 	Status: Needs review and discussion ?

I'm currently running some benchmarks (sysbench + MySQL) using AIO,
results will be available soon.

I will also release libposix-aio V0.5 at the same time.

(2) will sure help cleanup our code.

Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

