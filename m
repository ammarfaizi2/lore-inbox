Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262724AbREOK2w>; Tue, 15 May 2001 06:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbREOK2m>; Tue, 15 May 2001 06:28:42 -0400
Received: from t2.redhat.com ([199.183.24.243]:59631 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262724AbREOK23>; Tue, 15 May 2001 06:28:29 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.21.0105150424310.19333-100000@weyl.math.psu.edu> 
In-Reply-To: <Pine.GSO.4.21.0105150424310.19333-100000@weyl.math.psu.edu> 
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Chris Wedgwood <cw@f00f.org>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 May 2001 11:27:30 +0100
Message-ID: <17567.989922450@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


viro@math.psu.edu said:
> JFFS - dunno.

Bah. JFFS doesn't use any of those horrible block device thingies.

--
dwmw2


