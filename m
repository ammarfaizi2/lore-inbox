Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVIFSiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVIFSiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVIFSiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:38:07 -0400
Received: from web35908.mail.mud.yahoo.com ([66.163.179.192]:26789 "HELO
	web35908.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750787AbVIFSiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:38:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=x57hvqqg+MTS/Bx2H3THuUf0LXW2N7a7vJ6DjHPLGP8Wk5hDYW4O50t28zyrFkOrceaWuF0mcz+z8tHoO8W14xn4Zagxy02FMwh08Jqu64lz1cXCclHgpLBw4tlkaBxVRcYlSUobBWvW9fClTu4Q2YrMwuT7cHRzuVSVqKgaqc8=  ;
Message-ID: <20050906183804.84285.qmail@web35908.mail.mud.yahoo.com>
Date: Tue, 6 Sep 2005 19:38:04 +0100 (BST)
From: siva kumar <mobi_831978@yahoo.com>
Subject: Regarding pktgen tool in linux kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
I am using pktgen tool to test the performance of my
NIC for small packets that has more fragments. With
the pktgen, for 64 byte packet size and I am able to
set the maximum number of fragments as 5. Is it
possible to have more number of fragments in the given
64 / 128 byte packet size. I was going through the
code and could see that a check is been made to reset
the fragments count to predifined value, if it goes
beyond some limit.
 
Is it possible to modify the pktgen to support more
number of fragment in a given packet size?
 
Please let me know your view and provide me some
pointers.
 
Thanks,
~Mobi


Send instant messages to your online friends http://uk.messenger.yahoo.com 
