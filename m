Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLaL7Q>; Sun, 31 Dec 2000 06:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbQLaL65>; Sun, 31 Dec 2000 06:58:57 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:36363
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129383AbQLaL6w>; Sun, 31 Dec 2000 06:58:52 -0500
Date: Mon, 1 Jan 2001 00:28:24 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20010101002824.B21999@metastasis.f00f.org>
In-Reply-To: <20001230133910.A5341@emma1.emma.line.org> <E14CPNo-0006ny-00@the-village.bc.nu> <20001231113423.A5146@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001231113423.A5146@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sun, Dec 31, 2000 at 11:34:23AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Is there at least away we can recover the proper system time
    after these stalls?

re-read the RTC -- but that's pretty slow and ugly



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
