Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRKYTAz>; Sun, 25 Nov 2001 14:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280995AbRKYTAq>; Sun, 25 Nov 2001 14:00:46 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:40077 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280994AbRKYTAl>;
	Sun, 25 Nov 2001 14:00:41 -0500
Message-ID: <3C013FD4.25DAEE95@pobox.com>
Date: Sun, 25 Nov 2001 11:00:36 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@fenrus.demon.nl>
CC: James Davies <james_m_davies@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.13 Kernel and Ext3 vs Ext2
In-Reply-To: <E167zTW-0002SK-00@fenrus.demon.nl> <1006698831.1212624.0@smtp018.mail.yahoo.com> <20011125144902.A9714@fenrus.demon.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> rawhide != released !!!!!
> rawhide is a weekly development snapshot that is taken at basically a random
> time. Those kernels have seen no QA and are untested, they might not even
> boot.
>
> You're very welcome to help betatest them, and I welcome all bugreports
> against them; however considering them as released... no

I have an interesting story - I help out at a shop
where they run Red Hat samba servers, firewall,
ftp servers and vpn server. They run a program
called docuware on the samba clients BTW.

Anyway, when the offifical 2.4.3 kernel upgrade
from Red Hat came out, we upgraded all the 7.1
boxes by the book. Subsequently the docuware
server started crashing - hard lockup, very nasty.

All the customer had to do was run something
called "active import", and the box would hang.
(FWIW, it has 3ware controllers)

On a weekend you go for the quick fix - on a
whim we installed the rawhide 2.4.7-2 kernel,
had them run "active import" and crossed our
fingers. The box stayed solid. Since then it's
been up for about 100 days - all the boxes
there are now running that rawhide kernel.

Go figure!

cu

jjs

