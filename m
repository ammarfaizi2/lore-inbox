Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBNXWS>; Wed, 14 Feb 2001 18:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbRBNXWH>; Wed, 14 Feb 2001 18:22:07 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:36101 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129193AbRBNXWE>;
	Wed, 14 Feb 2001 18:22:04 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 14 Feb 2001 20:19:54 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200102142019.f1EKJsR20833@stev.org>
To: ppetru@ppetru.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECN for servers ?
In-Reply-To: <20010214190128.G923@ppetru.net>
In-Reply-To: <20010214190128.G923@ppetru.net>
Reply-To: mistral@stev.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

no they should not be effected
the place that starts the connection eg send the first SYN
has to ask to use ECN if it is not requested it will
never be used in that connection


In local.linux-kernel-list, you wrote:
>Hello,
>
>What is the impact of enabling ECN on the server side ? I mean, will
>any clients (with broken firewalls) be affected if a SMTP/HTTP server
>has ECN enabled ?
>
>On the other hand, is there any advantage with ECN enabled on the server
>side ?
>
>--
>Petru Paler, mailto:ppetru@ppetru.net
>http://www.ppetru.net - ICQ: 41817235
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  8:10pm  up 13 days,  3:55,  2 users,  load average: 0.08, 0.28, 0.14
