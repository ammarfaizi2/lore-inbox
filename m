Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRJNB4Z>; Sat, 13 Oct 2001 21:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRJNB4P>; Sat, 13 Oct 2001 21:56:15 -0400
Received: from cogito.cam.org ([198.168.100.2]:41735 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S273261AbRJNB4G>;
	Sat, 13 Oct 2001 21:56:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Date: Sat, 13 Oct 2001 21:51:15 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011014015115.E894D11718@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Sun, 14 Oct 2001, Riley Williams wrote:

>> He said in his original email that it was a USB SmartMedia reader,
>> which reads the SmartMedia cards used with FujiFilm digital cameras
>> (amongst others). The actual file system is determined by the cards
>> themselves and can't be changed.

>Ahem.  Which fs driver is used when it's successfully mounted?

fat.  Would an strace help?

TIA
Ed Tomlinson

