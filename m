Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVF1GaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVF1GaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVF1G3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:29:18 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:35713 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261712AbVF1GMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:12:51 -0400
Date: Tue, 28 Jun 2005 03:12:45 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels (was: Re: 2.6.12-mm2)
Message-ID: <20050628061245.GA5696@ime.usp.br>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org> <20050628040057.GA12499@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628040057.GA12499@phunnypharm.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28 2005, Ben Collins wrote:
> Unless something is in git that isn't in subversion, nothing has really
> changed in the sbp2 module for 5-6 months.

Is there any other information that I can provide you with that would help
track this?

> Doesn't appear to be a problem with the ieee1394 subsystem itself (the
> cycle master thing isn't all that important), since that would cause not
> even being able to send/recv packets.

So, could this be a problem with the SCSI layer, then?


Thank you, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
