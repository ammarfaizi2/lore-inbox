Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268942AbRG3Pd3>; Mon, 30 Jul 2001 11:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268946AbRG3PdT>; Mon, 30 Jul 2001 11:33:19 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:45841 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268942AbRG3PdB>;
	Mon, 30 Jul 2001 11:33:01 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Alon Ziv" <alonz@nolaviz.org>
cc: "Alexander Viro" <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] initramfs patch 
In-Reply-To: Your message of "Mon, 30 Jul 2001 18:25:27 +0200."
             <018101c11914$40bc3100$910201c0@zapper> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 01:33:01 +1000
Message-ID: <26248.996507181@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 18:25:27 +0200, 
"Alon Ziv" <alonz@nolaviz.org> wrote:
>I wonder...  May the initramfs be used also for loading modules ???
>Hmm... it will require a pico-insmod that can run in the limited initramfs
>environment, but I believe that's all !

Busybox includes a stripped down insmod, along with lots of other tools.
http://www.lineo.com/products/technical_bulletins/busy_box046.html

