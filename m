Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTLTKdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 05:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTLTKdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 05:33:25 -0500
Received: from 50.69-93-3.reverse.theplanet.com ([69.93.3.50]:4252 "EHLO
	spring.persianhosted.com") by vger.kernel.org with ESMTP
	id S263870AbTLTKdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 05:33:24 -0500
From: Armin <Zoup@zoup.org>
Organization: Zoup
Subject: Re: Xircom RealPort Pccard under 2.6.0
Date: Sat, 20 Dec 2003 13:58:26 -0900
User-Agent: KMail/1.5.4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312201358.26257.Zoup@zoup.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - spring.persianhosted.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zoup.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: Xircom RealPort Pccard under 2.6.0
Date: Saturday 20 December 2003 13:55
From: Armin <Zoup@zoup.org>
To: Armin <Zoup@zoup.org>

On Friday 19 December 2003 01:11, Armin wrote:
> im unable to get Xircom RealPort  RBEM56G under 2.6.0 .
> Yanta cardbus can install the bridge , but cardmgr can not detect it , i
> have installed last version of cardmanager ...
>
> also kernel compiled with Xircom Net Driver .
>
> many thanks , Great Release !

for 16-bit cards like xircom , its needed to enable pcmcia 16 bit support in
character devices and update pcmcia package to last version .
now its working :)

--
Kissing a fish is like smoking a bicycle.

