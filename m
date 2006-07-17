Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWGQJDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWGQJDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 05:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWGQJDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 05:03:48 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64958 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750804AbWGQJDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 05:03:47 -0400
Subject: Re: [NFS] nfs problems with 2.6.18-rc1
From: Tony Reix <tony.reix@bull.net>
To: Janos Farkas <chexum+dev@gmail.com>
Cc: =?ISO-8859-1?Q?Aim=E9?= Le Rouzic <Aime.Le-Rouzic@bull.net>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu>
References: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu>
Date: Mon, 17 Jul 2006 11:03:46 +0200
Message-Id: <1153127026.2871.12.camel@frecb000687.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/07/2006 11:08:13,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/07/2006 11:08:14,
	Serialize complete at 17/07/2006 11:08:14
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 13 juillet 2006 à 20:22 +0200, Janos Farkas a écrit :
> Hi!
> 
> I recently updated two (old) hosts to 2.6.18-rc1, and started noticing
> weird things with the nfs mounted /home s.
> 
> I frequently face EACCESs where a few minutes ago there wasn't any
> problem, and after a retry everything does work again.
> 
....

Do you have the same problem with the last stable version (2.6.17-rc2)
we have tested with in depth ?
See:	http://nfsv4.bullopensource.org/

Thanks,
Tony

