Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137106AbREKLNx>; Fri, 11 May 2001 07:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137107AbREKLNo>; Fri, 11 May 2001 07:13:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41879 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S137106AbREKLNh>;
	Fri, 11 May 2001 07:13:37 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15099.51549.316701.83524@pizda.ninka.net>
Date: Fri, 11 May 2001 04:13:33 -0700 (PDT)
To: Andi Kleen <ak@suse.de>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Source code compatibility in Stable series????
In-Reply-To: <20010511120341.A5112@gruyere.muc.suse.de>
In-Reply-To: <200105110947.LAA18167@cave.bitwizard.nl>
	<15099.46931.914571.475632@pizda.ninka.net>
	<20010511120341.A5112@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > I guess it would be possible to add a HAVE_ZEROCOPY to skbuff.h to make
 > it a bit easier for single source drivers.

Try MAX_SKB_FRAG, the drivers use that already.

Later,
David S. Miller
davem@redhat.com
