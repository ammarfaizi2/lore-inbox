Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSHKBrX>; Sat, 10 Aug 2002 21:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSHKBrX>; Sat, 10 Aug 2002 21:47:23 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:24348 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S317404AbSHKBrV>;
	Sat, 10 Aug 2002 21:47:21 -0400
From: <Hell.Surfers@cwctv.net>
To: _deepfire@mail.ru, linux-kernel@vger.kernel.org
Date: Sun, 11 Aug 2002 02:50:45 +0100
Subject: RE:2.5 and DRM/3D infrastructure?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1029030645321"
Message-ID: <052154249010b82DTVMAIL2@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1029030645321
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Couldn't support be in user space? The kernel doesnt even come with a bootloader, and 3d is more xfree86 ish...



On 	Sat, 10 Aug 2002 16:20:54 +0400 	"Samium Gromoff" <_deepfire@mail.ru> wrote:

--1029030645321
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Sat, 10 Aug 2002 13:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSHJMRL>; Sat, 10 Aug 2002 08:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSHJMRL>; Sat, 10 Aug 2002 08:17:11 -0400
Received: from mx1.mail.ru ([194.67.57.11]:62226 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id <S316883AbSHJMRJ>;
	Sat, 10 Aug 2002 08:17:09 -0400
Received: from f19.int ([10.0.0.139] helo=f19.mail.ru)
	by mx1.mail.ru with esmtp (Exim MX.1)
	id 17dVEk-0007xP-00
	for linux-kernel@vger.kernel.org; Sat, 10 Aug 2002 16:20:54 +0400
Received: from mail by f19.mail.ru with local (Exim FE.19)
	id 17dVEk-000HFm-00
	for linux-kernel@vger.kernel.org; Sat, 10 Aug 2002 16:20:54 +0400
Received: from [80.79.67.2] by koi.mail.ru with HTTP;
	Sat, 10 Aug 2002 16:20:54 +0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5 and DRM/3D infrastructure?
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 192.168.231.142 via proxy [80.79.67.2]
Date: Sat, 10 Aug 2002 16:20:54 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dVEk-000HFm-00@f19.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

    Regarding the list of planned changes for  2.5 i found that
  nothing is announced regarding DRI/DRM infrastructure.
    
    So i wonder whether the current situation is enough satisfactory,
  or is it just that nobody is interested in such kind of developement?

    Anyhow the current situation looks a bit odd, because we
  basically have support for a quite narrow diapasone of 3D
  accelerators.

  Does it look like the current interface could be not enough mature?

   (Note: this message is intended to catalyse
a fruitful
  discussion. hint, hint...)

---

cheers,
Samium Gromoff__________________
________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1029030645321--


