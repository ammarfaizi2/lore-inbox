Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbRBEHAv>; Mon, 5 Feb 2001 02:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129814AbRBEHAb>; Mon, 5 Feb 2001 02:00:31 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:9969 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129239AbRBEHA2>; Mon, 5 Feb 2001 02:00:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] make tmpfs_statfs more user friendly
In-Reply-To: <m31ytemq7u.fsf@linux.local>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <m31ytemq7u.fsf@linux.local>
Message-ID: <m3ae82l3mv.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 05 Feb 2001 08:05:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland <cr@sap.com> writes:

> The following patch make shmem_statfs report some sensible size
> estimates in the case that the user does not give a size limit.
> 
> This should make it more error prone when used as /tmp
                      ^^^^
Oh well, Lars pointed out that I was apparently in outer space
when typing this mail ;-)

So: s/more/less/

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
