Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRB0Kvp>; Tue, 27 Feb 2001 05:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbRB0Kvf>; Tue, 27 Feb 2001 05:51:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21888 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129749AbRB0KvS>;
	Tue, 27 Feb 2001 05:51:18 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15003.34336.1820.574668@pizda.ninka.net>
Date: Tue, 27 Feb 2001 02:49:03 -0800 (PST)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk>
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > Please note: although I am using 2.2.15pre13, it is _not_ the cause of
 > this problem

How do you know this?  There are so many deadly TCP bugs fixed
since 2.2.15pre13 I don't know how you can assert this.

Later,
David S. Miller
davem@redhat.com
