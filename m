Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317956AbSFSRsT>; Wed, 19 Jun 2002 13:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317957AbSFSRsS>; Wed, 19 Jun 2002 13:48:18 -0400
Received: from ns.suse.de ([213.95.15.193]:35082 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317956AbSFSRsQ>;
	Wed, 19 Jun 2002 13:48:16 -0400
Date: Wed, 19 Jun 2002 19:48:17 +0200
From: Dave Jones <davej@suse.de>
To: Brent Cook <busterb@mail.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File permission problem with NFSv3 and 2.5.20-dj4
Message-ID: <20020619194817.J29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Brent Cook <busterb@mail.utexas.edu>, linux-kernel@vger.kernel.org
References: <20020615142330.C16772@suse.de> <20020619124252.V4360-100000@abbey.hauschen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020619124252.V4360-100000@abbey.hauschen>; from busterb@mail.utexas.edu on Wed, Jun 19, 2002 at 12:45:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 12:45:31PM -0500, Brent Cook wrote:

 > You were right. Backing out READDIRPLUS fixes the problem with NFS and
 > files losing the executable bit. I just tried things with 2.5.23-dj1 and
 > all is well.

Excellent, thanks for testing..

 > Here are a couple of compile fixes for that kernel though:

Thanks, added to the pending queue with the others

    Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
