Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2XGf>; Fri, 29 Dec 2000 18:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130653AbQL2XGZ>; Fri, 29 Dec 2000 18:06:25 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:46085 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129930AbQL2XGM>;
	Fri, 29 Dec 2000 18:06:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank Jacobberger <f1j@xmission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: test13-pre5 + char-major-145?? 
In-Reply-To: Your message of "Fri, 29 Dec 2000 14:07:57 PDT."
             <3A4CFD2D.F7DE3125@xmission.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Dec 2000 09:35:40 +1100
Message-ID: <1782.978129340@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000 14:07:57 -0700, 
Frank Jacobberger <f1j@xmission.com> wrote:
>modprobe: Can't locate module char-major-145
>
>From /usr/src/linux/Documentation/devices.txt
>
>10 char        Non-serial mice, misc features
>145 = /dev/hfmodem      Soundcard shortwave modem control {2.6}

That is major 10, minor 145.  Search /145 *char/ to find char-major-145.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
