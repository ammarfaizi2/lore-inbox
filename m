Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTABGGO>; Thu, 2 Jan 2003 01:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTABGGO>; Thu, 2 Jan 2003 01:06:14 -0500
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:10069 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S265711AbTABGGL>;
	Thu, 2 Jan 2003 01:06:11 -0500
From: <Hell.Surfers@cwctv.net>
To: paulj@alphyra.ie, linux-kernel@vger.kernel.org
Date: Thu, 2 Jan 2003 06:14:09 +0000
Subject: RE:Re: Why is Nvidia given GPL'd code to use in closed source drivers?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1041488049304"
Message-ID: <0a50d1410060213DTVMAIL4@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1041488049304
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

if libc used compatible headers, they would be derivative....

Dean McEwan, If the drugs don't work, [sarcasm] take more...[/sarcasm].

On 	Thu, 2 Jan 2003 01:29:59 +0000 (GMT) 	Paul Jakma <paulj@alphyra.ie> wrote:

--1041488049304
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Thu, 2 Jan 2003 01:29:02 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTABBWm>; Wed, 1 Jan 2003 20:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTABBWm>; Wed, 1 Jan 2003 20:22:42 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:37127 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S265277AbTABBWl>; Wed, 1 Jan 2003 20:22:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by dunlop.admin.ie.alphyra.com (8.12.5/8.12.5) with ESMTP id h021TxZS030272;
	Thu, 2 Jan 2003 01:29:59 GMT
Date: Thu, 2 Jan 2003 01:29:59 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: David Lang <david.lang@digitalinsight.com>
cc: Paul Jakma <paul@clubi.ie>, Rik van Riel <riel@conectiva.com.br>,
	<Hell.Surfers@cwctv.net>, <linux-kernel@vger.kernel.org>,
	<rms@gnu.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <Pine.LNX.4.44.0301011706400.21656-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0301020126060.30005-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Wed, 1 Jan 2003, David Lang wrote:

> well libc uses the kernel headers and basicly all userspace programs
> use libc so that makes oracle a derivitive work of the kernel??????

libc neednt neccessarily use the kernel headers, it needs to use only 
headers that are compatible. Also, though it might use kernel headers, 
the headers it provides for other programmes to be compiled against it 
are not kernel headers.

further, the kernel's licence explicitely exempts the 'normal system 
calls', and kernel headers describing these can quite arguably be 
considered to fall within this exemption.

> luckly that's not how things actually work.

unfortunately, its not at all clear.

> David Lang

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1041488049304--


