Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130248AbQJaV6x>; Tue, 31 Oct 2000 16:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130723AbQJaV6o>; Tue, 31 Oct 2000 16:58:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41098 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130708AbQJaV6i>;
	Tue, 31 Oct 2000 16:58:38 -0500
Date: Tue, 31 Oct 2000 13:44:17 -0800
Message-Id: <200010312144.NAA19788@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jmerkey@timpanogas.org
CC: pmenage@ensim.com, riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <39FF3D53.C46EB1A8@timpanogas.org> (jmerkey@timpanogas.org)
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Tue, 31 Oct 2000 14:44:51 -0700
   From: "Jeff V. Merkey" <jmerkey@timpanogas.org>

   not web servers copying read only data from cache...

Actually, a sizable portion of SpecWEB99 is dynamic content, so it's
not all read-only.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
