Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSHZS7l>; Mon, 26 Aug 2002 14:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSHZS7l>; Mon, 26 Aug 2002 14:59:41 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:42050 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S318216AbSHZS7h>;
	Mon, 26 Aug 2002 14:59:37 -0400
From: <Hell.Surfers@cwctv.net>
To: thunder@lightweight.ods.org, pavel@elf.ucw.cz, stssppnn@yahoo.com,
       vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Date: Mon, 26 Aug 2002 20:01:00 +0100
Subject: RE:Re: [ANNOUNCE] New PC-Speaker driver
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1030388460153"
Message-ID: <0cd530301191a82DTVMAIL3@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1030388460153
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

and would slow the system timer... it wont unless sound loops... it could do with better static control... old debiansare only used by people without soundcards.. like 486dxs, and lazy oss support plagues the internal driver, which is why I gave up  upgrading it, STAS THINKS ITS A GOOD IDEA THOUGH, it plays slipknot well...



On 	Mon, 26 Aug 2002 12:33:04 -0600 (MDT) 	Thunder from the hill <thunder@lightweight.ods.org> wrote:

--1030388460153
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Mon, 26 Aug 2002 19:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSHZS3f>; Mon, 26 Aug 2002 14:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318249AbSHZS3f>; Mon, 26 Aug 2002 14:29:35 -0400
Received: from pD9E2394F.dip.t-dialin.net ([217.226.57.79]:30642 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318248AbSHZS3e>; Mon, 26 Aug 2002 14:29:34 -0400
Received: from hawkeye.luckynet.adm (hawkeye.luckynet.adm [192.168.1.1])
	by hawkeye.luckynet.adm (8.12.1/8.12.1) with ESMTP id g7QIX9nO009437;
	Mon, 26 Aug 2002 12:33:10 -0600
Date: Mon, 26 Aug 2002 12:33:04 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Pavel Machek <pavel@elf.ucw.cz>
cc: Stas Sergeev <stssppnn@yahoo.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] New PC-Speaker driver
In-Reply-To: <20020826112154.GA359@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0208261232140.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

Hi,

On Mon, 26 Aug 2002, Pavel Machek wrote:
> What problems does Jaroslav have with the driver?

I remember someone mentioned a PC-speaker driver would eat up too many 
interrupts, and would also not be maintained but rot in the corner...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
..- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1030388460153--


