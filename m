Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281534AbRKMGSt>; Tue, 13 Nov 2001 01:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281535AbRKMGSj>; Tue, 13 Nov 2001 01:18:39 -0500
Received: from rj.sgi.com ([204.94.215.100]:64999 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281534AbRKMGSZ>;
	Tue, 13 Nov 2001 01:18:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: neilb@cse.unsw.edu.au, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan 
In-Reply-To: Your message of "Mon, 12 Nov 2001 22:03:41 -0800."
             <20011112.220341.54186374.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 17:18:15 +1100
Message-ID: <12705.1005632295@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore previous mail, the pointer cannot be const, the structure it
points to can be.

