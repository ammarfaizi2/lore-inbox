Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVKFRYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVKFRYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVKFRYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:24:43 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:25069 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932180AbVKFRYm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:24:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ox6R8JJhFcREEd5h7H4rrRH0/e/hfYwoUpNrWhM7muxE1+lHl8vQBDQNGT1gA7905E3wNfFq27UWMkZJ1yytEn86QPGVeZM5XkZ4TcFqYTh18brLbqWBmk4CzTIWr5paW7qamShr8sWs4exTh5zigUpaIh1y2BKH/T96Kl082A8=
Message-ID: <8413367b0511060924s550024b8w1113564cd6bb9340@mail.gmail.com>
Date: Sun, 6 Nov 2005 18:24:39 +0100
From: <grfgguvf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Whys and hows of initrds
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I don't know if the LKML is a technical kernel development list or a
newbie support list (or both?) so maybe I'm posting to the wrong
place.

Questions:
* Why is an initrd needed?
* What does it do?
* What are the differences between an initrd and an initramdisk (if
any)? And an initramfs?
* Why cannot the task of initrds be done more easily?
* Why don't other operating systems need an equivalent? Or do they?

Opinions and technical explanations welcome. Please, no excessive flames!

I have searched the FAQs, HOWTOs and guides on tldp.org, but it seems
to me there is no "initrd FAQ". If I just didn't find it then I
welcome any pointers and sorry for wasting time...
