Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRCNQ6x>; Wed, 14 Mar 2001 11:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131466AbRCNQ6o>; Wed, 14 Mar 2001 11:58:44 -0500
Received: from limes.hometree.net ([194.231.17.49]:32576 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S131472AbRCNQ6e>; Wed, 14 Mar 2001 11:58:34 -0500
To: linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2001 16:36:55 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <98o6n7$6i1$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <UTC200103141601.RAA189084.aeb@vlet.cwi.nl>
Reply-To: hps@tanstaafl.de
Subject: Re: [PATCH] Improved version reporting
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:

>Looking at fdformat to get the util-linux version is perhaps
>not the most reliable way - some people have fdformat from fd-utils or so.
>Using mount --version would be better - I am not aware of any
>other mount distribution.

Bad idea. RedHat has mount and util-linux in different RPMs (at least 6.x).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
