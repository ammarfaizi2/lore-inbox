Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTCYBLK>; Mon, 24 Mar 2003 20:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbTCYBLK>; Mon, 24 Mar 2003 20:11:10 -0500
Received: from web10408.mail.yahoo.com ([216.136.130.110]:42932 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261312AbTCYBLJ>; Mon, 24 Mar 2003 20:11:09 -0500
Message-ID: <20030325012218.62722.qmail@web10408.mail.yahoo.com>
Date: Tue, 25 Mar 2003 12:22:18 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: System lock up with 2.4.20
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1618209615-1048555338=:62633"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1618209615-1048555338=:62633
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I got system lockup (can not move mouse pointer,
everything is frozen) while playing mplayer just about
10 seconds with stock kernel 2.4.20 with and without
slackware kernel patches (fix ext3 and ptrace stuff).
Compile with gcc-3.2.x (from slackware) ; and gcc-2.93
; both in slackware and debian testing. The problem
doesn't happen with 2.4.19-pre6 the older is ok as far
as I remember; here I attach the dmesg for more
information. The thing is standard slackware doesn't
have gcc-2.93 and kernel 2.4.19-pre6 compiled with
gcc-3.2 oops just after boot so it is rather difficult
for me to compile some modules now, hope to see it is
fixed.

The error even happened when no tainted modules loaded
(lt_serial, lt_modem, vmmon, vmnet)

Regards,




=====
Steve Kieu
>From New Zealand

http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
--0-1618209615-1048555338=:62633
Content-Type: X-unknown/directory; name="dmesg.log"
Content-Transfer-Encoding: base64
Content-Description: dmesg.log
Content-Disposition: attachment; filename="dmesg.log"

ZG1lc2cubG9n

--0-1618209615-1048555338=:62633--
