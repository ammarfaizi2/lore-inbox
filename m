Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbQKURBq>; Tue, 21 Nov 2000 12:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbQKURBg>; Tue, 21 Nov 2000 12:01:36 -0500
Received: from Cantor.suse.de ([194.112.123.193]:52237 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129942AbQKURBY>;
	Tue, 21 Nov 2000 12:01:24 -0500
Mail-Copies-To: never
To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Large filesystem?
In-Reply-To: <001301c053d7$347c2880$7930000a@hcd.net>
From: Andreas Jaeger <aj@suse.de>
Date: 21 Nov 2000 17:31:21 +0100
In-Reply-To: <001301c053d7$347c2880$7930000a@hcd.net>
Message-ID: <hovgth8exy.fsf@gee.suse.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Timothy A DeWees writes:

 > Hello kernel hackers,
 >     Can anyonw point me to doc on how to setup large filesytem support on
 > 2.2?
Use 2.4 - or apply Andrea's patches (somewhere on ftp.*.kernel.org) -
and then rebuild glibc.

For details check also: http://www.suse.de/~aj/linux_lfs.html

Andreas
 > We are using linux to do network backups with Microlite and some of our
 > backups are growing above 2 Gb.  Thanks is advance!

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
